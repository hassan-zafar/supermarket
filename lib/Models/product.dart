import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String? productId;
  final String? Name;
  final String? Description;
  final String? Brand;

  final String? price;
  final String? imageURL;
  final bool? isIndividual;
  final bool? isFavorite;
  final int? counter_selected;
  final double? price_continete;
  final double? price_auchan;
  final double? price_pingodoce;
  final double? price_intermarche;
  final double? price_mini;
  final double? price_spar;

  Product({
    this.productId,
    this.Name,
    this.Description,
    this.Brand,
    this.price,
    this.imageURL,
    this.isIndividual,
    this.isFavorite,
    this.counter_selected,
    this.price_auchan,
    this.price_continete,
    this.price_intermarche,
    this.price_mini,
    this.price_pingodoce,
    this.price_spar,
  });
  factory Product.fromDocument(doc) {
    return Product(
      // productId: doc.data()["productId"],
      Name: doc.data()["Name"],
      Description: doc.data()["Description"],
      price: doc.data()["price"],
      imageURL: doc.data()["imageURL"],
      Brand: doc.data()["Brand"],
      isIndividual: doc.data()["isIndividual"],
      isFavorite: doc.data()["isFavorite"],
      price_intermarche: doc.data()["price_intermarche"],
      price_mini: doc.data()["price_mini"],
      price_spar: doc.data()["price_spar"],
      price_pingodoce: doc.data()["price_pingodoce"],
      price_auchan: doc.data()["price_auchan"],
      price_continete: doc.data()["price_continete"],
      counter_selected: doc.data()["counter_selected"],
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'Name': Name,
      'description': Description,
      'Brand': Brand,
      'price': price,
      'imageURL': imageURL,
      'isIndividual': isIndividual,
      'isFavorite': isFavorite,
      'price_intermarche': price_intermarche,
      'price_mini': price_mini,
      'price_spar': price_spar,
      'price_pingodoce': price_pingodoce,
      'price_auchan': price_auchan,
      'price_continete': price_continete,
      'countericer_selected': counter_selected,
    };
  }
}
