class Customer {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final String? skinTone;
  final Map<String, dynamic>? bodyMeasurements;

  Customer({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.skinTone,
    this.bodyMeasurements,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      photoUrl: json['photo_url'],
      skinTone: json['skin_tone'],
      bodyMeasurements: json['body_measurements'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photo_url': photoUrl,
      'skin_tone': skinTone,
      'body_measurements': bodyMeasurements,
    };
  }
}