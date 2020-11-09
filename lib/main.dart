import 'package:create_shop/providers/auth_provider.dart';
import 'package:create_shop/providers/cart_provider.dart';
import 'package:create_shop/providers/order_provider.dart';
import 'package:create_shop/providers/product_provider.dart';
import 'package:create_shop/util/app_routes.dart';
import 'package:create_shop/views/auth_home_screen.dart';
import 'package:create_shop/views/auth_screen.dart';
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
          create: (_)=> new AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          create: (_)=>new ProductProvider(),
          update: (context, auth, previousProducts)=>new ProductProvider(auth.token,auth.userId,previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (_)=> new Cart(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, Orders>(
          create: (_)=>new Orders(),
          update: (context, auth, previousProducts)=>new Orders(auth.token,auth.userId,previousProducts.items),
        ),

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
          AppRoutes.AUTH_HOME: (context)=> AuthOrHomeScreen(),
          //AppRoutes.HOME: (context)=> ProductOverviewScreen(),
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
