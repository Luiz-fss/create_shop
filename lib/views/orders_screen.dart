import 'package:create_shop/providers/order_provider.dart';
import 'package:create_shop/widgets/app_drawer.dart';
import 'package:create_shop/widgets/orders_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (context, index){
            return OrdersWidget(
              orders.items[index]
            );
          }),
    );
  }
}
