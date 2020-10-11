import 'package:create_shop/models/product.dart';
import 'package:create_shop/providers/cartProvider.dart';
import 'package:create_shop/util/app_routes.dart';
import 'package:create_shop/views/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {

  /*
  final Product product;
  ProductItem(this.product);

   */
  @override
  Widget build(BuildContext context) {
     Product product = Provider.of<Product>(context,listen: false);
    final Cart cart = Provider.of<Cart>(context,listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: (){

          Navigator.of(context).pushNamed(
            AppRoutes.PRODUCT_DETAIL,
            arguments: product
          );
          /*
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>ProductDetailScreen(product))
          );

           */
        },
        child: GridTile(
          child: Image.network(product.imageUrl,fit: BoxFit.cover,),
          //parte de baixo
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder:(context,product,_)=> IconButton(
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: (){
                  product.toggleFavorite();
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                cart.addItem(product);
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
