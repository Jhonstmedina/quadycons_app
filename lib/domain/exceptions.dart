class GeneralException {
  final String message;
  const GeneralException({required this.message});
}




class ServerException extends GeneralException {

  static const unauthorizedStatus = 401;
  
  final int statusCode;

  const ServerException({
    required super.message,
    required this.statusCode
  });
}