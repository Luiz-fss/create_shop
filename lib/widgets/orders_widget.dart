import 'package:create_shop/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersWidget extends StatefulWidget {

  final Order order;

  OrdersWidget(this.order);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "R\$ ${widget.order.amount.toStringAsFixed(2)}"
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date)
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.expand_more
              ),
              onPressed: (){
               setState(() {
                 _expanded = !_expanded;
               });
              },
            ),
          ),
          if(_expanded==true)
          Container(
            height: (widget.order.products.length * 25.0) + 10,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
            child: ListView(
              children: widget.order.products.map((prod){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        prod.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    Text(
                      "${prod.quantity} x R\$ ${prod.price}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey
                      ),
                    )
                  ],
                );
              }).toList(),
            ),
          )

        ],
      ),
    );
  }
}
