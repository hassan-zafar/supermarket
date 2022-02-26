import 'package:supermarket/Models/cart_attr.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};

  Map<String, CartAttr> get getCartItems {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 0.0;
    // _cartItems.forEach((key, value) {
    //   total += value.price! * value.quantity!;
    // });
    return total;
  }

  void addProductToCart(
      String productId, String price, String title, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      // removeItem(productId);
      _cartItems.update(
          productId,
          (exitingCartItem) => CartAttr(
              id: exitingCartItem.id,
              productId: exitingCartItem.productId,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity! + 1,
              imageUrl: exitingCartItem.imageUrl));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartAttr(
              id: DateTime.now().toString(),
              productId: productId,
              title: title,
              price: price,
              quantity: 1,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void reduceItemByOne(
    String productId,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCartItem) => CartAttr(
              id: exitingCartItem.id,
              productId: exitingCartItem.productId,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity! - 1,
              imageUrl: exitingCartItem.imageUrl));
    }

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
