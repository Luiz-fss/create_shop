
import 'package:create_shop/providers/product_provider.dart';
import 'package:create_shop/util/app_routes.dart';
import 'package:create_shop/widgets/app_drawer.dart';
import 'package:create_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {

  Future<void> _refreshProducts(BuildContext context)async{
    /*LEMBRETE SEMPRE QUE ESTIVER UTILIZANDO O PROVIDER FORA DA ARVORE DE
    * RENDERIZAÇÃO (fora do build) É PRECISO MUDAR O LISTEN DO PROVIDER PARA FALSE*/
    await Provider.of<ProductProvider>(context,listen: false).loadProducts();
  }


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
      body: RefreshIndicator(
        onRefresh: (){
          return _refreshProducts(context);
        },
        child: Padding(
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
      ),
    );
  }
}
