import 'package:create_shop/util/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              "Bem-Vindo Usuário",
            ),
            //propriedade que deixa como falso o ícone de exibição do drawer
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shop
            ),
            title: Text(
              "Loja"
            ),
            onTap: (){
              Navigator.of(context).popAndPushNamed(
                AppRoutes.HOME
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
                Icons.payment
            ),
            title: Text(
                "Pedidos"
            ),
            onTap: (){
              Navigator.of(context).popAndPushNamed(
                  AppRoutes.ORDERS
              );
            },
          ),
        ],
      ),
    );
  }
}
