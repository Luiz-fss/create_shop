import 'package:create_shop/data/dummy_data.dart';
import 'package:create_shop/models/product.dart';
import 'package:create_shop/providers/cartProvider.dart';
import 'package:create_shop/providers/product_provider.dart';
import 'package:create_shop/util/app_routes.dart';
import 'package:create_shop/widgets/app_drawer.dart';
import 'package:create_shop/widgets/badge.dart';
import 'package:create_shop/widgets/grid_product.dart';
import 'package:create_shop/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions{
  FAVORITE,
  ALL
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {

  bool _showFavoriteOnly=false;

  @override
  Widget build(BuildContext context) {
    //final ProductProvider productProvider = Provider.of(context);
    //final Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha loja"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if(selectedValue == FilterOptions.FAVORITE){
                  //productProvider.showFavoriteOnly();
                  _showFavoriteOnly=true;

                }else{
                  //productProvider.showAll();
                  _showFavoriteOnly=false;
                }
              });
            },
            itemBuilder: (context){
              return [
                PopupMenuItem(
                  child: Text("Somente Favoritos"),
                  value: FilterOptions.FAVORITE,
                ),
                PopupMenuItem(
                  child: Text("Todos"),
                  value: FilterOptions.ALL,
                ),
              ];
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.of(context).pushNamed(
                  AppRoutes.CART
                );
              },
            ),
            builder:(_,cart,child)=> Badge(
              value: cart.itemCount.toString(),
              child: child,
            ),
          )
        ],
      ),
      body: GridProduct(_showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}


