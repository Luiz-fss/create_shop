
import 'package:create_shop/providers/product_provider.dart';
import 'package:create_shop/util/app_routes.dart';
import 'package:create_shop/widgets/app_drawer.dart';
import 'package:create_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    final productList = products.items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Produtos"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM
              );
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(

        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.productCount,
          itemBuilder: (context,index){
            return Column(
              children: <Widget>[
                ProductItem(productList[index]),
                Divider()
              ],
            );
          },
        ),
      ),
    );
  }
}
