class OutfitRecommendation {
  final String id;
  final String description;
  final List<Product> products;
  final DateTime createdAt;

  OutfitRecommendation({
    required this.id,
    required this.description,
    required this.products,
    required this.createdAt,
  });

  factory OutfitRecommendation.fromJson(Map<String, dynamic> json) {
    return OutfitRecommendation(
      id: json['id'],
      description: json['description'],
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String productUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.productUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['image_url'],
      productUrl: json['product_url'],
    );
  }
}