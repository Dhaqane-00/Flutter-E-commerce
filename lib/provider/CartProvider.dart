import 'package:flutter/foundation.dart';
import '../../models/Cart.dart';

class CartNotifier extends ChangeNotifier {
  List<Cart> _carts = demoCarts;

  List<Cart> get carts => _carts;

  int get itemCount => _carts.length;

  void addCart(Cart cart) {
    _carts.add(cart);
    notifyListeners();
  }

  void removeCart(int index) {
    _carts.removeAt(index);
    notifyListeners();
  }
}
