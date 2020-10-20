import 'package:create_shop/providers/cart_provider.dart';
import 'package:create_shop/providers/counter_provider.dart';
import 'package:create_shop/providers/order_provider.dart';
import 'package:create_shop/providers/product_provider.dart';
import 'package:create_shop/util/app_routes.dart';
import 'package:create_shop/views/cart_screen.dart';
import 'package:create_shop/views/orders_screen.dart';
import 'package:create_shop/views/product_detail_screen.dart';
import 'package:create_shop/views/product_form_screen.dart';
import 'package:create_shop/views/products_overview_screen.dart';
import 'package:create_shop/views/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> new ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_)=> new Cart(),
        ),
        ChangeNotifierProvider(
          create: (_)=> new Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: "Lato"
        ),
        //home: ProductOverviewScreen(),
        routes: {
          AppRoutes.HOME: (context)=> ProductOverviewScreen(),
          AppRoutes.PRODUCT_DETAIL: (context)=> ProductDetailScreen(),
          AppRoutes.CART: (context)=> CartScreen(),
          AppRoutes.ORDERS: (context)=>OrdersScreen(),
          AppRoutes.PRODUCTS: (context)=>ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (context)=>ProductFormScreen(),
        },
      ),
    );
  }
}
