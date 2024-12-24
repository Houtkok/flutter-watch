import 'package:flutter/material.dart';

import 'product.dart';
import 'user.dart';

class ProductManager extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(User user, Product product) {
    if (user.role == Role.admin) {
      _products.add(product);
      notifyListeners();
      print('${product.name} added successfully.');
    } else {
      print('Only admins can add products.');
    }
  }
}
