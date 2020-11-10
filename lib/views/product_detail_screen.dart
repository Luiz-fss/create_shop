import 'package:create_shop/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Product product = ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      //appBar: AppBar(
        //title: Text(
          //product.title
        //),
      //),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            //mesma altura do container
            expandedHeight: 300,
            //app bar vai ficar "pinado" sempre vai aparecer
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  DecoratedBox(decoration: BoxDecoration(
                    gradient:LinearGradient(
                      begin: Alignment(0,0.8),
                      end: Alignment(0,0),
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.6),
                        Color.fromRGBO(0, 0, 0, 0)
                      ]
                    ),
                  )
                  )
                ],
              )
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(
            [

              SizedBox(height: 10,),
              Text(

                "R\$ ${product.price}",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,

                ),
              ),
            ],
          ),)
        ],
      ),
    );
  }
}
