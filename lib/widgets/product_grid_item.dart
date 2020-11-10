import 'package:create_shop/models/product.dart';
import 'package:create_shop/providers/auth_provider.dart';
import 'package:create_shop/providers/cart_provider.dart';
import 'package:create_shop/util/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {

  /*
  final Product product;
  ProductItem(this.product);

   */
  @override
  Widget build(BuildContext context) {
     Product product = Provider.of<Product>(context,listen: false);
    final Cart cart = Provider.of<Cart>(context,listen: false);
    final AuthProvider authProvider = Provider.of(context,listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
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
          child: Hero(
            tag: product.id,
            child: FadeInImage(
                placeholder: AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavorite(authProvider.token,authProvider.userId);
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Produto adicionado com sucesso!',
                  ),
                  duration: Duration(seconds: 5),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );

            },
          ),
        ),
      ),
    );
  }
}
