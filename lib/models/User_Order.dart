// user_order.dart
import 'dart:convert';

class UserOrder {
  final String? id;
  final String? user;
  final String? payment;
  final List<OrderProduct>? products;
  final double? total;
  final String? phone;
  final String? note;
  final DateTime? createdAt;

  UserOrder({
    this.id,
    this.user,
    this.payment,
    this.products,
    this.total,
    this.phone,
    this.note,
    this.createdAt,
  });

  factory UserOrder.fromJson(Map<String, dynamic> json) {
    return UserOrder(
      id: json['_id'],
      user: json['user'],
      payment: json['payment'],
      products: (json['products'] as List?)
          ?.map((productJson) => OrderProduct.fromJson(productJson))
          .toList(),
      total: (json['total'] as num?)?.toDouble(),
      phone: json['phone'],
      note: json['note'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}

class OrderProduct {
  final ProductDetails? productDetails;
  final int? quantity;

  OrderProduct({this.productDetails, this.quantity});

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      productDetails: ProductDetails.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}

class ProductDetails {
  final String? id;
  final String? name;
  final String? description;
  final List<String>? images;
  final double? price;
  final double? salePrice;

  ProductDetails({
    this.id,
    this.name,
    this.description,
    this.images,
    this.price,
    this.salePrice,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      images: (json['images'] as List?)?.map((item) => item as String).toList(),
      price: (json['price'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] as num?)?.toDouble(),
    );
  }
}
