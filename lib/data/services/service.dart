import 'package:dio/dio.dart';
import 'package:quadycons/domain/exceptions.dart';

abstract class Service {
  final Dio dio;
  Service({required this.dio});

  Future<Response> executeDioService(
    Future<Response> Function() service
  )async{
    try{
      final response = await service();
      final statusCode = response.statusCode;
      if(statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 203 || statusCode == 205 || statusCode == 206 || statusCode == 208) {
        return response;
      } else if(statusCode == 401) {
        throw const GeneralException(message: 'Sin autorización');
      } else {
        print(response.data);
        throw GeneralException(message: response.data['error']['message'] ?? 'Ha ocurrido un error inesperado' );
      }
    }on GeneralException catch(_){
      rethrow;
    }catch(exception, stackTrace){
      print(stackTrace);
      throw const GeneralException(message: 'Ha ocurrido un error inesperado');
    }
  }

  Map<String, String> getJsonContentHeaders() => {
    'Content-Type': 'application/json'
  };
}