import 'package:shop_app/models/Product.dart';

class Order {
  String? user;
  String? payment;
  List<Product>? products; // Updated type to List<Product>
  double? total;
  String? note;
  String? phone;

  Order({
    this.user,
    this.payment,
    this.products,
    this.total,
    this.note,
    this.phone,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      user: json['user'],
      payment: json['payment'],
      products: (json['products'] as List<dynamic>?)
          ?.map((productJson) => Product.fromJson(productJson))
          .toList(),
      total: json['total'] != null ? json['total'].toDouble() : null,
      note: json['note'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['payment'] = payment;
    data['products'] = products?.map((product) => product.toJson()).toList();
    data['total'] = total;
    data['note'] = note;
    data['phone'] = phone;
    return data;
  }
}
