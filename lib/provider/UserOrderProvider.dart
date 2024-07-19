// order_provider.dart
import 'package:flutter/foundation.dart';
import 'package:shop_app/models/User_Order.dart';
import 'package:shop_app/server/UserOrder.dart';

class UserOrderProvider with ChangeNotifier {
  final UserOrderService _service = UserOrderService();
  List<UserOrder> _userOrders = [];
  bool _isLoading = false;

  List<UserOrder> get userOrders => _userOrders;
  bool get isLoading => _isLoading;

  Future<void> fetchUserOrders(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _userOrders = await _service.fetchUserOrders(userId);
    } catch (e) {
      // Handle error
      print('Error fetching user orders: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
