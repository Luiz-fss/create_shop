import 'package:create_shop/exceptions/http_exceptions.dart';
import 'package:create_shop/models/product.dart';
import 'package:create_shop/providers/product_provider.dart';
import 'package:create_shop/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {

  final Product product;
  ProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(
        product.title,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: (){
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Excluir Produto"),
                      content: Text("Tem certeza?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Não"
                          ),
                          onPressed: (){
                            Navigator.of(context).pop(false);
                          },
                        ),
                        FlatButton(
                          child: Text(
                              "Sim"
                          ),
                          onPressed: (){
                            //Provider.of<ProductProvider>(context,listen: false).deleteProduct(product.id);
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  }
                ).then((value)async{
                  if(value) {
                    try{
                      await Provider.of<ProductProvider>(context,listen: false).deleteProduct(product.id);
                    }on HttpExceptions catch(e){
                      scaffold.showSnackBar(SnackBar(
                        content: Text(e.toString()),
                      ));
                    }
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
