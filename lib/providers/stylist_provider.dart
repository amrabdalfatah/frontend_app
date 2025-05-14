import 'package:fashion_app/models/message.dart';
import 'package:fashion_app/models/outfit.dart';
import 'package:fashion_app/services/api_service.dart';
import 'package:flutter/material.dart';

class StylistProvider with ChangeNotifier {
  List<Message> _messages = [];
  OutfitRecommendation? _currentRecommendation;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Message> get messages => _messages;
  OutfitRecommendation? get currentRecommendation => _currentRecommendation;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Clear chat history
  void clearChat() {
    _messages.clear();
    _currentRecommendation = null;
    _error = null;
    notifyListeners();
  }

  // Load chat history (from local storage/API)
  Future<void> loadChatHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Implement your chat history loading logic here
      //  _messages = await ApiService.getChatHistory();
      await Future.delayed(Duration(seconds: 1)); // Simulate loading
    } catch (e) {
      _error = 'Failed to load chat history';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Send message to AI stylist
  Future<void> sendMessage(String text) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Add user message
    _messages.add(Message(text: text, isUser: true));
    notifyListeners();

    try {
      // Get AI response
      final recommendations = await ApiService.getRecommendations(text);

      if (recommendations.isNotEmpty) {
        _currentRecommendation = recommendations.first;
        _messages.add(
          Message(text: recommendations.first.description, isUser: false),
        );
      } else {
        _messages.add(
          Message(
            text: 'No recommendations found for your request',
            isUser: false,
          ),
        );
      }
    } catch (e) {
      _error = 'Failed to get recommendations';
      _messages.add(
        Message(
          text: 'Sorry, I encountered an error. Please try again.',
          isUser: false,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save chat history (to local storage/API)
  Future<void> saveChatHistory() async {
    try {
      // Implement your save logic here
      // Example: await ApiService.saveChatHistory(_messages);
    } catch (e) {
      _error = 'Failed to save chat history';
      notifyListeners();
    }
  }
}
