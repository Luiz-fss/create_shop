import 'dart:math';
import 'package:create_shop/data/dummy_data.dart';
import 'package:create_shop/models/product.dart';
import 'package:flutter/material.dart';
class ProductProvider with ChangeNotifier{
  List<Product> _items = DUMMY_PRODUCT;

  List<Product> get items{
      return [..._items];
  }

  List<Product> get favoriteItems{
    return _items.where((prod) => prod.isFavorite).toList();
  }

  int get productCount {
    return _items.length;
  }

  void addProduct(Product newProduct){
    _items.add(Product(
      id: Random().nextDouble().toString(),
      title: newProduct.title,
      description: newProduct.description,
      price: newProduct.price,
      imageUrl: newProduct.imageUrl
    ));
    notifyListeners();
  }

  void updateProduct(Product product){
    //necessário que o produto esteja com id setado
    if(product ==null || product.id==null){
      return ;
    }
   final index = _items.indexWhere((prod){
     return prod.id == product.id;
    });
    if(index>=0){
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id){
    final index = _items.indexWhere((prod){
      return prod.id == id;
    });
    if(index >=0){
      _items.removeWhere((prod){
        /*se os ids forem iguais siginifica que esse elemento foi excluido*/
        return prod.id ==id;
        notifyListeners();
      });
    }

  }

}




//bool _showFavoriteOnly = false;
/*
  void showFavoriteOnly(){
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll(){
    _showFavoriteOnly = false;
    notifyListeners();
  }
   */