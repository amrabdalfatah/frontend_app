import 'package:flutter/material.dart';

class SkinTonePicker extends StatelessWidget {
  final ValueChanged<String> onToneSelected;
  
  const SkinTonePicker({super.key, required this.onToneSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select your skin tone:', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: List.generate(10, (index) {
            final tone = index + 1;
            return GestureDetector(
              onTap: () => onToneSelected(tone.toString()),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _getToneColor(tone),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Color _getToneColor(int tone) {
    // Map MST scale to approximate colors
    const colors = [
      Color(0xFFFFF5E1), // 1
      Color(0xFFF3D9B5),
      Color(0xFFEAC8A4),
      Color(0xFFD4AE8D),
      Color(0xFFC08F6F),
      Color(0xFFA57254),
      Color(0xFF8D5A3C),
      Color(0xFF6F3E26),
      Color(0xFF4E2A1A),
      Color(0xFF3A1D0D), // 10
    ];
    return colors[tone - 1];
  }
}