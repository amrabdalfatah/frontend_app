class AnalysisResultModel {
  final String id;
  final String userId;
  final String imagePath;
  final String skinTone;
  final String recommendedColor;
  final double confidence;
  final List<String> colorOptions;
  final DateTime createdAt;

  AnalysisResultModel({
    required this.id,
    required this.userId,
    required this.imagePath,
    required this.skinTone,
    required this.recommendedColor,
    required this.confidence,
    required this.colorOptions,
    required this.createdAt,
  });

  factory AnalysisResultModel.fromJson(Map<String, dynamic> json) {
    return AnalysisResultModel(
      id: json['id'],
      userId: json['user'],
      imagePath: json['image_path'],
      skinTone: json['skin_tone'],
      recommendedColor: json['recommended_color'],
      confidence: json['confidence'].toDouble(),
      colorOptions:
          (json['color_options'] as List)
              .map((color) => color.toString())
              .toList(),

      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
