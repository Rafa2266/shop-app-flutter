import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if ((_items[productId]?.quantity ?? 0) <= 1) {
      _items.remove(productId);
    } else {
      _items.update(
          productId,
          (existing) => CartItem(
              id: existing.id,
              productId: existing.productId,
              name: existing.name,
              quantity: existing.quantity - 1,
              price: existing.price));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (existing) => CartItem(
              id: existing.id,
              productId: existing.productId,
              name: existing.name,
              quantity: existing.quantity + 1,
              price: existing.price));
    } else {
      _items.addAll({
        product.id: CartItem(
            id: Random().nextDouble().toString(),
            productId: product.id,
            name: product.name,
            quantity: 1,
            price: product.price)
      });
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }
}
