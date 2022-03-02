import 'package:flutter/material.dart';

class CartAttr with ChangeNotifier {
  final String? id;
  final String? productName;
  final String? title;
  final int? quantity;
  final String? price;
  final String? imageUrl;

  CartAttr(
      {this.id,
      @required this.productName,
      this.title,
      this.quantity,
      this.price,
      this.imageUrl});
}
