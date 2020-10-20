import 'dart:math';
import 'package:create_shop/providers/cart_provider.dart';
import 'package:flutter/material.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;


  Order({
    this.id,
    this.amount,
    this.products,
    this.date
  });

}


class Orders with ChangeNotifier{
  List<Order> _items=[];

  List<Order> get items{
    return[..._items];
  }

  void addOrder (Cart cart) {
    _items.insert(0, Order(
        id: Random().nextDouble().toString(),
        amount: cart.totalAmount,
        date: DateTime.now(),
        products: cart.item.values.toList()
    ));
    notifyListeners();
  }

  int get itemsCount{
    return _items.length;
  }
}