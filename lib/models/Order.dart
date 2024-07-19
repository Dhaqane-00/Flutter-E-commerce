class Order {
  String? user;
  String? payment;
  List<Map<String, dynamic>>? products;
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
      user: json['user'] as String?,
      payment: json['payment'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((productJson) => {
                'product': productJson['product'] as String,
                'quantity': productJson['quantity'] as int,
              })
          .toList(),
      total: (json['total'] as num?)?.toDouble(), // Correctly handle 'total'
      note: json['note'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['payment'] = payment;
    data['products'] = products;
    data['total'] = total;
    data['note'] = note;
    data['phone'] = phone;
    return data;
  }
}
