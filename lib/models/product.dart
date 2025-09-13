import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/constants.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
  void _changeFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    _changeFavorite();
    const url = Constants.productBaseUrl;
    final response = await http.patch(
      Uri.parse('$url/$id.json'),
      body: jsonEncode(
        {
          "isFavorite": isFavorite,
        },
      ),
    );
    if (response.statusCode >= 400) {
      _changeFavorite();
      throw HttpExceptionFire(
          msg: "Não foi possível mudar o status de favorito",
          statusCode: response.statusCode);
    }
  }
}
