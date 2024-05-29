class Product {
  final String id;
  final String title, description;
  final List<String> images;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });

  // Factory constructor to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],  // Changed to match the API's string type
      title: json['name'],
      description: json['description'],
      images: List<String>.from(json['images']),
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      isFavourite: json['isFavourite'],
      isPopular: json['isTrending'],
    );
  }

  toJson() {}
}
