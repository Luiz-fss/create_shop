import 'package:create_shop/providers/cart_provider.dart';
import 'package:create_shop/providers/product_provider.dart';
import 'package:create_shop/util/app_routes.dart';
import 'package:create_shop/widgets/app_drawer.dart';
import 'package:create_shop/widgets/badge.dart';
import 'package:create_shop/widgets/grid_product.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*Obtendo os dados do firebase*/
    Provider.of<ProductProvider>(context,listen: false).loadProducts().then((_){
      setState(() {
        _isLoading = false;
      });
    });
  }

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
            itemBuilder: (_){
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

          //Consumer vai alterar um ponto especifico dentro da arvore
          Consumer<Cart>(
            builder:(_,cart,child)=> Badge(
              value: cart.itemCount.toString(),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: (){
                    Navigator.of(context).pushNamed(
                        AppRoutes.CART
                    );
                  },

                )
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(),)
          :GridProduct(_showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}


