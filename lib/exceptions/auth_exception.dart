class AuthException implements Exception{

  /*Definição de uma série de erros já documentados no firebase*/
  static const Map<String,String> errors = {
    //signUp
    "EMAIL_EXISTS":"E-mail existente", //email já utilizado por outra conta
    "OPERATION_NOT_ALLOWED":"Operação não permitida",//operação não disponivel
    "TOO_MANY_ATTEMPS_TRY_LATER":"Tente mais tarde", //muitas tentativas para fazer o login
    //login
    "EMAIL_NOT_FOUND":"E-mail não encontrado",
    "INVALID_PASSWORD":"Senha ínvalida",
    "USER_DISABLED":"Usuário desativado"
  };

  final String key;

  const AuthException(this.key);
  @override
  String toString() {
    // TODO: implement toString
    if(errors.containsKey(key)){

      return errors[key];
    }else{
      return "Ocorreu um erro na autenticação";
    }
  }

}