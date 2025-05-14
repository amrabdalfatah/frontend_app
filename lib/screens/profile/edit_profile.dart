import 'dart:convert';
import 'dart:io';

import 'package:fashion_app/models/analysis_result_model.dart';
import 'package:fashion_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _skinTone;
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String? _imagePath;

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Upload to Django backend for skin tone analysis
      _imagePath = image.path;
      final analysisResultJson = await ApiService.analyzeSkinTone(image.path);
      final analysisRes = AnalysisResultModel.fromJson(
        jsonDecode(analysisResultJson) as Map<String, dynamic>,
      );
      final skinTone = analysisRes.skinTone;
      setState(() => _skinTone = skinTone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complete Your Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    _imagePath == null
                        ? AssetImage('assets/default_avatar.png')
                        : FileImage(File(_imagePath!)),
              ),
              TextButton(
                onPressed: _pickImage,
                child: Text('Upload Photo for Skin Tone Analysis'),
              ),
              if (_skinTone != null)
                Text(
                  'Detected Skin Tone: $_skinTone',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 20),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ApiService.updateProfile(
                      skinTone: _skinTone!,
                      height: _heightController.text,
                      weight: _weightController.text,
                    );
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
