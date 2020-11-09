import 'package:create_shop/providers/auth_provider.dart';
import 'package:create_shop/providers/order_provider.dart';
import 'package:create_shop/views/auth_screen.dart';
import 'package:create_shop/views/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    return FutureBuilder(
      future: authProvider.tryAutoLogin(),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.error != null){
          return Center(child: Text("Ocorreu um erro"),);
        }else{
          return authProvider.isAuth ? ProductOverviewScreen()
              : AuthScreen();
        }
      },
    );
  }

}
