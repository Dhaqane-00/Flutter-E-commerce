class OrderItem {
  final String orderId;
  final int itemCount;
  final String deliveryType;
  final String status;
  final String imageUrl;

  OrderItem({
    required this.orderId,
    required this.itemCount,
    required this.deliveryType,
    required this.status,
    required this.imageUrl,
  });
}
