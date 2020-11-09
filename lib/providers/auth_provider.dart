import 'dart:async';
import 'dart:convert';
import 'package:create_shop/data/storage.dart';
import 'package:create_shop/exceptions/auth_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier{
  //static const _url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAka5cJZoFKHuAOsNFD0piUzufC6K2-Ut0';
  //static const _urlSignIn = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAka5cJZoFKHuAOsNFD0piUzufC6K2-Ut0";


  //Variavéis para o token
  String _token;
  String _userId;
  DateTime _expireDate;
  Timer _logoutTimer;

  //getter para acessar o token
  bool get isAuth {
    return token != null;
  }
  String get token{
    if(_token != null || _expireDate != null || _expireDate.isAfter(DateTime.now())){
      return _token;
    }else{
      return null;
    }
  }

  String get userId{
    return isAuth ? _userId : null;
  }

  Future<void> _authenticate (String email, String password, String urlSegment)async{
   final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAka5cJZoFKHuAOsNFD0piUzufC6K2-Ut0';

   final response = await http.post(
     url,
     body: json.encode({
       "email":email,
       "password": password,
       "returnSecureToken": true
     }),
   );
   //tratando erros na autenticação
   final responseBody =json.decode(response.body);
   if(responseBody["error"] !=null){
     throw AuthException(responseBody["error"]["message"]);
   }else{
     _token = responseBody["idToken"];
     _userId = responseBody["localId"];
     _expireDate = DateTime.now().add(
         Duration(
             seconds: int.parse(responseBody["expiresIn"])
         )
     );
     Store.saveMap("userData", {
       "token":_token,
       "userId": _userId,
       "expiryDate":_expireDate.toIso8601String()
     });
   }
   _autoLogout();

   notifyListeners();
   //print(json.decode(response.body));

   return Future.value();
  }

  //primeiro cadastro
  Future<void> signup (String email, String password)async{
    return _authenticate(email, password, "signUp");
  }

  //Login
  Future<void> signin (String email, String password)async{
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> tryAutoLogin()async{
    if(isAuth){
      return Future.value();
    }
   final userData =await Store.getMap("userDate");
    if(userData==null){
      return Future.value();
    }
    final expiryDate = DateTime.parse(userData["expiryDate"]);
    if(expiryDate.isBefore(DateTime.now())){
      return Future.value();
    }
    _userId = userData["userId"];
    _token = userData["token"];
    _expireDate = expiryDate;
    _autoLogout();
    notifyListeners();
    Future.value();
    
  }

  //deslogar
  void logout(){
    _token = null;
    _userId = null;
    _expireDate = null;
    if(_logoutTimer != null){
      _logoutTimer.cancel();
      _logoutTimer=null;
    }
    Store.remove("userData");
    notifyListeners();
  }
  //deslogar automaticamente
  void _autoLogout(){
    if(_logoutTimer != null){
      _logoutTimer.cancel();
    }
    final timeToLogout = _expireDate.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout),logout);
  }


}