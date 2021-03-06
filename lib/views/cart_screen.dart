import 'package:create_shop/providers/cart_provider.dart';
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
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  OrderButton(cart: cart,)

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

class OrderButton extends StatefulWidget{
  const OrderButton({
    Key key,
    @required this.cart,
}) : super (key: key);
  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      onPressed: widget.cart.totalAmount == 0 ? null : ()async{
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Orders>(context,listen: false).addOrder(widget.cart);
        setState(() {
          _isLoading=false;
        });
        widget.cart.clear();
      },
      child: _isLoading ? CircularProgressIndicator() : Text(
          "COMPRAR"
      ),
      textColor: Theme.of(context).primaryColor,
    );
  }
}