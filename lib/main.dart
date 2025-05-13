import 'package:fashion_app/providers/auth_provider.dart';
import 'package:fashion_app/providers/stylist_provider.dart';
import 'package:fashion_app/screens/auth/login_screen.dart';
import 'package:fashion_app/screens/auth/signup_screen.dart';
import 'package:fashion_app/screens/chat/chat_screen.dart';
import 'package:fashion_app/screens/chat/recommendation_screen.dart';
import 'package:fashion_app/screens/home/home_screen.dart';
import 'package:fashion_app/screens/profile/edit_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => StylistProvider()),
      ],
      child: MaterialApp(
        title: 'AI Fashion Stylist',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => AuthWrapper(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/profile': (context) => EditProfileScreen(),
          '/home': (context) => HomeScreen(),
          '/chat': (context) => ChatScreen(),
          '/recommendations': (context) => RecommendationScreen(),
        },
      ),
    ),
  );
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.user == null) return LoginScreen();
    if (!auth.profileComplete) return EditProfileScreen();
    return HomeScreen();
  }
}
