import 'package:create_shop/providers/auth_provider.dart';
import 'package:create_shop/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                AppRoutes.AUTH_HOME
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
          Divider(),
          ListTile(
            leading: Icon(
                Icons.edit
            ),
            title: Text(
                "Gerenciar produtos"
            ),
            onTap: (){
              Navigator.of(context).popAndPushNamed(
                  AppRoutes.PRODUCTS
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
                Icons.exit_to_app
            ),
            title: Text(
                "Sair"
            ),
            onTap: (){
              Provider.of<AuthProvider>(context).logout();
            },
          ),
        ],
      ),
    );
  }
}
