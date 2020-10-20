import 'dart:math';

import 'package:create_shop/models/product.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price
  });
}


class Cart with ChangeNotifier{


  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item{
    return {..._items};
  }
  
  int get itemCount{
    return _items.length;
  }

  void addItem(Product product){
    if(_items.containsKey(product.id)){
      _items.update(product.id, (existingItem){
        return CartItem(
            id: existingItem.id,
            productId: product.id,
            title: existingItem.title,
            quantity: existingItem.quantity +1,
            price: existingItem.price
        );
      });
    }else{
      //putIfAbsent = incluir se não estiver presente
      _items.putIfAbsent(product.id, (){
        return CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          title: product.title,
          price: product.price,
          quantity: 1,
        );
      });
    }
    notifyListeners();
  }
  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  //total
  double get totalAmount{
    double totalPrice = 0.0;
    _items.forEach((key,cartItem){
      totalPrice += cartItem.price * cartItem.quantity;
    });
    return totalPrice;
  }

  void clear(){
    _items={};
    notifyListeners();
  }

  void removeSingleItem(productId){
    if(!_items.containsKey(productId)){
      //produto não está presente
      return;
    }

    if(_items[productId].quantity == 0){
      _items.remove(productId);
    }else{
      _items.update(productId, (existingItem){
        return CartItem(
            id: existingItem.id,
            productId: existingItem.productId,
            title:existingItem.title,
            quantity: existingItem.quantity - 1,
            price: existingItem.price
        );
      });
    }

    notifyListeners();
  }
}