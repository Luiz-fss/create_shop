
import 'package:create_shop/models/product.dart';
import 'package:create_shop/providers/product_provider.dart';
import 'package:create_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridProduct extends StatelessWidget {

  final bool showFavoriteOnly;
  GridProduct(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    final products = showFavoriteOnly ? productsProvider.favoriteItems : productsProvider.items;

    return  GridView.builder(
        itemCount: products.length,
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //quantidade de elementos por linha
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
        ),
        itemBuilder: (context, index){
          return ChangeNotifierProvider.value(
            value: products[index],
              child: ProductItem()
          );
        }
    );
  }
}
