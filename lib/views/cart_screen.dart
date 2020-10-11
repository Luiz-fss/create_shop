import 'package:create_shop/providers/cartProvider.dart';
import 'package:create_shop/providers/order_provider.dart';
import 'package:create_shop/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Cart cart = Provider.of<Cart>(context);
    final cartItems = cart.item.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
      body: Column(
        //definição da exibição do "total"
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  SizedBox(width: 10,),
                  Chip(
                    label: Text(
                      "R\$ ${cart.totalAmount}",
                       style: TextStyle(
                         color: Theme.of(context).primaryTextTheme.title.color
                       ),
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: (){
                      Provider.of<Orders>(context,listen: false).addOrder(cart);
                      cart.clear();
                    },
                    child: Text(
                      "COMPRAR"
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )

                ],
              ),
            ),
          ),
          //fim da exibição do total

          //inicio da lista dos itens
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (context,index){
                  return CartItemWidget(cartItems[index]);
                }
            ),
          )
        ],
      ),
    );
  }
}
