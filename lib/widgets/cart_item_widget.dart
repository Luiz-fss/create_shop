import 'package:create_shop/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {

  final CartItem cartItem;
  CartItemWidget(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
      ),

      direction: DismissDirection.endToStart,

      //-colocando confirmação no desmissible com um Dialog
      confirmDismiss: (_){
        return showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text(
                "Você tem certeza?"
              ),
              content: Text(
                "Quer remover o item do carrinho?"
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    /*O showDialog retorna um valor quando ele é resolvido
                    nesse caso ao fechar a tela com o .pop(false)
                    ele vai passar como falso, ou seja, não vai confirmar o
                    dismiss, assim não vai remover o item arrastado*/
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Não"),
                ),
                FlatButton(
                  onPressed: (){
                    /*O showDialog retorna um valor quando ele é resolvido
                    * nesse caso ao fechar a tela com o .pop(true)
                    * ele vai passar como true, ou seja vai confirmar o dismiss
                    * assim o item será arrastado e removido*/
                    Navigator.of(context).pop(true);
                  },

                  child: Text("Sim"),
                )
              ],
            );
          }
        );
      },

      onDismissed: (_){
        Provider.of<Cart>(context,listen: false).removeItem(cartItem.productId);
      },

      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    "R\$${cartItem.price}"
                  ),
                ),
              ),
            ),
            title: Text(
              cartItem.title
            ),
            subtitle: Text(
              "Total : R\$${cartItem.price * cartItem.quantity}"
            ),
            trailing: Text(
              "${cartItem.quantity}x"
            ),

          ),
        ),
      ),
    );
  }
}
