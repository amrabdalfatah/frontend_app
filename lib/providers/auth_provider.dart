import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  Customer? _customer;
  bool _isLoading = false;

  Customer? get user => _customer;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _customer != null;
  bool get profileComplete => _customer?.skinTone != null;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Map Firebase user to our User model
      _customer = Customer(
        id: credential.user!.uid,
        email: credential.user!.email!,
        name: credential.user!.displayName ?? 'User',
        photoUrl: credential.user!.photoURL,
      );
    } catch (error) {
      throw error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signup(String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await credential.user!.updateDisplayName(name);
      
      _customer= Customer(
        id: credential.user!.uid,
        email: email,
        name: name,
      );
    } catch (error) {
      throw error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _customer = null;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      _customer = Customer(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName ?? 'User',
        photoUrl: firebaseUser.photoURL,
      );
      notifyListeners();
    }
  }
}