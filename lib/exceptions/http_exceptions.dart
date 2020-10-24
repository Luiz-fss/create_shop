class HttpExceptions implements Exception{
  final String msg;

  const HttpExceptions(this.msg);

  @override
  String toString() {
    // TODO: implement toString
    return msg;
  }
}