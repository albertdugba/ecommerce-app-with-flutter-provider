import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String productID, double price, String title) {
    if (_items.containsKey(productID)) {
      _items.update(
        productID,
        (currentCartItem) => CartItem(
          id: currentCartItem.id,
          title: currentCartItem.title,
          quantity: currentCartItem.quantity + 1,
          price: currentCartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productID,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void removeCartItem(String productID) {
    _items.remove(productID);
    notifyListeners();
  }
}
