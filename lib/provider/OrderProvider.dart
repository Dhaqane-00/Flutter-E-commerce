import 'package:flutter/material.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/server/Order.dart';

enum OrderState { normal, loading, success, error, networkError }

class OrderProvider with ChangeNotifier {
  OrderState _orderState = OrderState.normal;
  String? _errorMessage;

  OrderState get orderState => _orderState;
  String? get errorMessage => _errorMessage;

  Future<void> placeOrder({
    required Order order,
    Function()? onSuccess,
    Function(String)? onError,
  }) async {
    try {
      _orderState = OrderState.loading;
      notifyListeners();
      await OrderServices().order(
        user: order.user!,
        payment: order.payment!,
        products: order.products!,
        total: order.total!,
        note: order.note!,
        phone: order.phone!,
      );
      _orderState = OrderState.success;
      notifyListeners();
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      _orderState = OrderState.error;
      _errorMessage = e.toString();
      notifyListeners();
      if (onError != null) {
        onError(_errorMessage!);
      }
    }
  }
}
