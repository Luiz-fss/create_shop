import 'dart:convert';
import 'package:create_shop/exceptions/http_exceptions.dart';
import 'package:create_shop/models/product.dart';
import 'package:create_shop/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ProductProvider with ChangeNotifier{

  /*regra do firebase diz que precisa terminar o link da url com .json
    * até o .com é a url base
    *Foi tirado do método e adicionado direto na classe o link*/
   final String _BaseUrl = "${Constants.BASE_API_URL}/products";


  List<Product> _items = [];

  List<Product> get items{
      return [..._items];
  }

  List<Product> get favoriteItems{
    return _items.where((prod) => prod.isFavorite).toList();
  }

  int get productCount {
    return _items.length;
  }

  //Carregar dados
   Future<void>loadProducts()async{
    final response = await http.get("$_BaseUrl.json");
    Map<String,dynamic> data = json.decode(response.body);
    if(data !=null)
    data.forEach((productId, productData){
      //correção da duplicidade das listas ao ficar trocando de tela
      _items.clear();

      _items.add(Product(
        id: productId,
        title: productData["title"],
        description: productData["description"],
        price: productData["price"],
        imageUrl: productData["imageUrl"],
        isFavorite: productData["isFavorite"]
      ));
      notifyListeners();
    });
    return Future.value();
   }


  Future<void> addProduct(Product newProduct)async{

/*
    /*teste para passar dados*/
    final mapa = {
      "atributo 1":"valor 1",
      "atributo 2":"valor 2",
      "atributo 3":["valor","valor","valor"],
    };


 */
    final resposta = await http.post(
        "$_BaseUrl.json",
      body: json.encode({
        "title":newProduct.title,
        "descritpion":newProduct.description,
        "price":newProduct.price,
        "imageUrl":newProduct.imageUrl,
        "isFavorite":newProduct.isFavorite
      })
    );
    _items.add(Product(
        id: json.decode(resposta.body)["name"],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl
    ));
    notifyListeners();
    /*
      _items.add(Product(
          id: json.decode(resposta.body)[""],
          title: json.decode(resposta.body)[""],
          description: json.decode(resposta.body)[""],
          price: json.decode(resposta.body)[""],
          imageUrl: json.decode(resposta.body)[""]
      ));
      notifyListeners();

       */
  }


  Future<void> updateProduct(Product product)async{
    //necessário que o produto esteja com id setado
    if(product ==null || product.id==null){
      return ;
    }
   final index = _items.indexWhere((prod){
     return prod.id == product.id;
    });
    if(index>=0){
      await http.patch("$_BaseUrl/${product.id}.json",
      body: json.encode({
        "title":product.title,
        "descritpion":product.description,
        "price":product.price,
        "imageUrl":product.imageUrl,
      }));
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id)async{
    final index = _items.indexWhere((prod){
      return prod.id == id;
    });
    if(index >=0){
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete("$_BaseUrl/${product.id}.json");

      //>400 erro na requisição. >500 erro de servidor
      if(response.statusCode >= 400){
        _items.insert(index, product);
        notifyListeners();
        throw HttpExceptions("Ocorreu um erro na exclusão do produto");
      }


      /*
      _items.removeWhere((prod){
        /*se os ids forem iguais siginifica que esse elemento foi excluido*/
        return prod.id ==id;
        notifyListeners();
      });

       */
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