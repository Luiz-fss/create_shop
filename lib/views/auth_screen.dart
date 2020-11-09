import 'dart:math';
import 'package:create_shop/widgets/auth_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 0.5),
                  Color.fromRGBO(255, 188, 215, 0.9),
                ],
                begin: Alignment.topLeft,

                end: Alignment.bottomRight
              )
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Minha Loja",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline.color,
                      fontSize: 35,
                      fontFamily: 'Anton'
                    ),
                  ),
                  //Fazendo uma pequena rotação
                  //.. operador chamada em cascata
                  /*Segundo ponto faz com que chama uma outra função
                  * porém o resultado retornado é a operação anterior*/
                  transform: Matrix4.rotationZ(-8.0 * pi / 180)..translate(-10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepOrange.shade900,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black26,
                        offset: Offset(0,2)
                      )
                    ]
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 70),
                ),
                AuthCard()
              ],
            ),
          )

        ],
      ),
    );
  }
}
