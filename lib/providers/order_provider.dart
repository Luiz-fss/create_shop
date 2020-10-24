import 'dart:convert';
import 'dart:math';
import 'package:create_shop/providers/cart_provider.dart';
import 'package:create_shop/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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


  /*regra do firebase diz que precisa terminar o link da url com .json
    * até o .com é a url base
    *Foi tirado do método e adicionado direto na classe o link*/
  final String _BaseUrl = "${Constants.BASE_API_URL}/orders";

  List<Order> _items=[];

  List<Order> get items{
    return[..._items];
  }

  //Carregar dados
  Future<void>loadOrders()async{

    List<Order> loadedItems=[];

    final response = await http.get("$_BaseUrl.json");
    Map<String,dynamic> data = json.decode(response.body);

    if(data !=null)
      data.forEach((orderId, ordertData){
        loadedItems.add(Order(
          id: orderId,
          amount: ordertData["amount"],
          date: DateTime.parse(ordertData['date']),
          products: (ordertData["products"] as List<dynamic>).map((item){
            return CartItem(
                id: item["id"],
                productId: item["productId"],
                title: item["title"],
                quantity: item["quantity"],
                price: item["price"]
            );
          }).toList()
        ));
      });
    _items = loadedItems.reversed.toList();
    return Future.value();
  }


  Future<void> addOrder (Cart cart) async{

    /*Variavé de data criada para tanto a order local como a coleção do firebase
    * terem a mesma data*/
    //DateTime dateTime = DateTime.now();
    final dateTime = DateTime.now();

    final response = await http.post("$_BaseUrl.json",
    body: json.encode({
      "amount":cart.totalAmount,
      "date":dateTime.toIso8601String(),//Formato padronizado
      "products":cart.item.values.map((cartItem)=>{
        "id":cartItem.id,
        "productId":cartItem.productId,
        "title":cartItem.title,
        "quatity":cartItem.quantity,
        "price":cartItem.price,
      }).toList()
    }));
    _items.insert(0, Order(
        id: json.decode(response.body)["name"],
        amount: cart.totalAmount,
        date: dateTime,
        products: cart.item.values.toList()
    ));
    notifyListeners();
  }

  int get itemsCount{
    return _items.length;
  }
}