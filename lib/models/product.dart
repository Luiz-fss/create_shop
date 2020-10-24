import 'dart:convert';
import 'package:create_shop/util/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Product with ChangeNotifier{

  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {
       this.id,
       @required this.title,
       @required this.description,
       @required this.price,
       @required this.imageUrl,
       this.isFavorite=false
      }
      );

    void changeFavorite(){
      isFavorite = !isFavorite;
      notifyListeners();
    }
    Future<void>toggleFavorite()async{
      changeFavorite();
    try{
      final url = "${Constants.BASE_API_URL}/products.${id}.json";

      final response = await http.patch(url,
          body: json.encode({
            "isFavorite": isFavorite
          }));
      if(response.statusCode>=400){
        changeFavorite();
      }
    }catch(e){
      changeFavorite();
    }
  }
}