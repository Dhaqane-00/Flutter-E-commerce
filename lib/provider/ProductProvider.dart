import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/server/Product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _searchResults = [];
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
  List<Product> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get error => _error;

  final ProductServices _productServices = ProductServices();

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productServices.fetchProducts();
      _searchResults = _products; // Initially, all products are shown as search results
    } catch (error) {
      _error = error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _searchResults = _products;
    } else {
      _searchResults = _products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
