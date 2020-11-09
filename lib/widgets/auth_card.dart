import 'package:create_shop/exceptions/auth_exception.dart';
import 'package:create_shop/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode{SingUp,Login}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {

  GlobalKey<FormState> _key = GlobalKey();

  /*Variavél que vai ajudar no controle.
  * Quando o usuário clicar em entrar os dados vão ir para o firebase
  * durante o processo, não seria viável que ele ficasse clicando repetidas vezes
  * no botão. Então a variavél vai desabilitar o campo enquanto envia os dados
  * ao firebase e aguarda o retorno*/
  bool _isLoading = false;

  /*Pegando o valor do campo de senha para poder comparar com o valor informado
    * na confirmação, para ter certeza que a senha e a confirmação estão alinhadas
    * e poder subimiter o formulário*/
  final _passwordController = TextEditingController();

  /*Atriuto que define o modo de autenticação da aplicação*/
  AuthMode _authMode = AuthMode.Login;


  Map<String, String> _authData={
    "email":"",
    "password":""
  };

  void _showErroDialog(String msg){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Ocorreu um erro"),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Fechar"),
            )
          ],
        );
      }
    );
  }

  Future<void> _submit() async{
    if(!_key.currentState.validate()){
      return ;
    }
    setState(() {
      _isLoading = true;
    });

    _key.currentState.save();

    AuthProvider authProvider = Provider.of<AuthProvider>(context,listen: false);

    try{
      if(_authMode == AuthMode.Login){
        //login
        await authProvider.signin(_authData["email"], _authData["password"]);
      }else{
        //Registrar
        await authProvider.signup(_authData["email"], _authData["password"]);
      }
    }on AuthException catch(erro){
      _showErroDialog(erro.toString());
    }catch(erro){
      _showErroDialog("Ocorreu um erro inesperado");
    }


    setState(() {
      _isLoading = false;
    });
    //limpando os campos
    _key.currentState.reset();
    _passwordController.text = "";
  }

  void _switchMode(){
    if(_authMode == AuthMode.Login){
      setState(() {
        _authMode = AuthMode.SingUp;
      });
    }else{
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Pegando tamanho do sipositivo
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      elevation: 8.0,
      child: Container(
        padding: EdgeInsets.all(16),
        height: _authMode == AuthMode.Login ? 290 : 371,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _key,
          child: Column(
            //correção da altura do container
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //Campo Email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email"
                ),
                validator: (valor){
                  if(valor.isEmpty || !valor.contains('@')){
                    return "Informe um E-mail válido";
                  }
                  return null;
                },
                onSaved: (valor){
                  _authData["email"] = valor;
                },
              ),
              //Campo senha
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: "Senha"
                ),
                validator: (valor){
                  if(valor.isEmpty && valor.length < 5){
                    return "Informe uma senha válida";
                  }
                  return null;
                },
                onSaved: (valor){
                  _authData["password"] = valor;
                },
              ),

              //Confirmação de senha de o modo de autenticação for singup

              if(_authMode == AuthMode.SingUp)
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Confirmar Senha"
                ),
                 validator: _authMode == AuthMode.SingUp ? (valor){
                  if(valor != _passwordController.text){
                    return "Senhas diferentes";
                  }
                  return null;
                } : null,
              ),

              Spacer(),

              //Botão de login / cadastro
              if(_isLoading)
                CircularProgressIndicator()
              else
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryTextTheme.button.color,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                child: _authMode == AuthMode.Login ? Text("ENTRAR")
                : Text("REGISTRAR"),
                onPressed: (){
                  _submit();
                },
              ),
              FlatButton(
                child: Text(
                  "ALTERNAR P/ ${_authMode == AuthMode.Login ? "REGISTRAR" : "LOGIN"}"
                ),
                textColor: Theme.of(context).primaryColor,
                onPressed: _switchMode,
              )
            ],
          ),
        )
      ),
    );
  }
}
