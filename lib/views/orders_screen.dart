  import 'package:create_shop/providers/order_provider.dart';
  import 'package:create_shop/widgets/app_drawer.dart';
  import 'package:create_shop/widgets/orders_widget.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';

  class OrdersScreen extends StatelessWidget {

    Future<void> _refreshOrders(BuildContext context)async{
      /*LEMBRETE SEMPRE QUE ESTIVER UTILIZANDO O PROVIDER FORA DA ARVORE DE
      * RENDERIZAÇÃO (fora do build) É PRECISO MUDAR O LISTEN DO PROVIDER PARA FALSE*/
      await Provider.of<Orders>(context,listen: false).loadOrders();
    }

    @override
    Widget build(BuildContext context) {
     //comentado pq foi usado um consumer
     // final Orders orders = Provider.of(context);
      return Scaffold(
        appBar: AppBar(
          title: Text("Meus Pedidos"),
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: (){
            return _refreshOrders(context);
          },
          child: FutureBuilder(
            future: Provider.of<Orders>(context,listen: false).loadOrders(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.error != null){
                return Center(child: Text("Ocorreu um erro inesperado"),);
              }else{
                return Consumer<Orders>(
                  builder: (context,orders,child){
                    return ListView.builder(
                        itemCount: orders.itemsCount,
                        itemBuilder: (context, index){
                          return OrdersWidget(
                              orders.items[index]
                          );
                        });
                  },
                );
              }
            },
          ),
        ),
      );
    }
  }
