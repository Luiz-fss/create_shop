import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({@required builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  /*sobrescrevendo o método da classe herdada(MaterialPageRoute) responsável pela
  transição*/

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    //caso queria dar uma animação diferente para uma tela espeficifica
    if(settings.name == "/nomeDaRota"){
      return child;
    }
    //caso não seja a rota
    return FadeTransition(opacity: animation,child: child,);

  }
}


//page, forma global

class CustomPageTransictionBuilder extends PageTransitionsBuilder {


  /*sobrescrevendo o método da classe herdada(MaterialPageRoute) responsável pela
  transição*/

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {

      return FadeTransition(opacity: animation,child: child,);

    /*
    //caso queria dar uma animação diferente para uma tela espeficifica
    if(settings.name == "/nomeDaRota"){
      return child;
    }
    //caso não seja a rota
    return FadeTransition(opacity: animation,child: child,);
    */
      }
}

