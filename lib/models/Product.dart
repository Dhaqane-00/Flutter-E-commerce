class Product {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final double rating;
  final double price;
  final double salePrice;
  final DateTime salePriceDate;
  final bool isFavourite;
  final bool isPopular;
  final int units;
  final String category;
  final String createdBy;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.rating,
    required this.price,
    required this.salePrice,
    required this.salePriceDate,
    required this.isFavourite,
    required this.isPopular,
    required this.units,
    required this.category,
    required this.createdBy,
    required this.createdAt,
  });

  // Factory constructor to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      title: json['name'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      price: json['price']?.toDouble() ?? 0.0,
      salePrice: json['salePrice']?.toDouble() ?? 0.0,
      salePriceDate: json['salePriceDate'] != null
          ? DateTime.parse(json['salePriceDate'])
          : DateTime.now(), // Provide a default date or handle null case
      rating: json['rating']?.toDouble() ?? 0.0,
      isFavourite: json['isFavourite'] ?? false,
      isPopular: json['isTrending'] ?? false,
      units: json['units'] ?? 0,
      category: json['category'] ?? '',
      createdBy: json['createdBy'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(), // Provide a default date or handle null case
    );
  }

  // Convert a Product to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': title,
      'description': description,
      'images': images,
      'price': price,
      'salePrice': salePrice,
      'salePriceDate': salePriceDate.toIso8601String(),
      'rating': rating,
      'isFavourite': isFavourite,
      'isTrending': isPopular,
      'units': units,
      'category': category,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
