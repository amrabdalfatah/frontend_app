import 'dart:convert';

import 'package:fashion_app/models/outfit.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://localhost:8000/api';
  static String? _authToken; // Store authentication token

  static Future<String> analyzeSkinTone(String imagePath) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$_baseUrl/analyze/'),
    );
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    final response = await request.send();
    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString())['mst_score'];
    }
    throw Exception('Failed to analyze skin tone');
  }

  static Future getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/retail/'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['products'] as List)
            .map((e) => OutfitRecommendation.fromJson(e))
            .toList();
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network Error: $e');
    }
  }

  static Future<List<OutfitRecommendation>> getRecommendations(
    String query,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat'),
        body: jsonEncode({'message': query}),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${YOUR_AUTH_TOKEN}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['recommendations'] as List)
            .map((e) => OutfitRecommendation.fromJson(e))
            .toList();
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network Error: $e');
    }
  }

  static Future<void> updateProfile({
    required String skinTone,
    required String height,
    required String weight,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_authToken',
        },
        body: jsonEncode({
          'skin_tone': skinTone,
          'height': height,
          'weight': weight,
        }),
      );

      if (response.statusCode == 200) {
        // Success
        final data = jsonDecode(response.body);
        print("Data: $data");
      } else {
        throw Exception('Failed to update profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Add this method to set the auth token after login
  static void setAuthToken(String token) {
    _authToken = token;
  }
}
