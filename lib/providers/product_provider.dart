
import 'package:create_shop/data/dummy_data.dart';
import 'package:create_shop/models/product.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier{
  List<Product> _items = DUMMY_PRODUCT;



  List<Product> get items{
      return [..._items];
  }

  List<Product> get favoriteItems{
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product){
    _items.add(product);
    notifyListeners();
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