import 'package:dio/dio.dart';
import 'package:quadycons/domain/entities/authentication.dart';
import 'package:quadycons/domain/entities/user.dart';
import 'package:quadycons/data/services/service.dart';
import 'package:quadycons/domain/exceptions.dart';

abstract class AuthService {
  Future<String> login(Authentication auth);
  Future<void> logout(String accessToken);
  Future<User> getUser(String accessToken);
}

class AuthServiceImpl extends Service implements AuthService {
  
  
  AuthServiceImpl({required super.dio});

  @override
  Future<String> login(Authentication auth) async {
    try {
      final response = await dio.post(
        'auth/login/',
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }
        ),
        data: {
          'email': auth.userName,
          'password': auth.password
        }
      );
      return response.data['token'];
    } on DioException catch(e) {
      print('❌ DIO ERROR');
      print('Status: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('Message: ${e.message}');
      if(e.response != null && e.response?.statusCode == 400) {
        throw GeneralException(
          message: 'Credenciales inválidas'
        );
      }
      rethrow;
    } catch (e) {
      print('❌ UNKNOWN ERROR: $e');
      rethrow;
    }
  }
  
  @override
  Future<void> logout(String accessToken) async {
    await super.executeDioService(() async => await dio.post(
        'auth/logout/',
        options: super.getBaseOptions(accessToken)
      )
    );
  }
  
  @override
  Future<User> getUser(String accessToken) async {
    final response = await super.executeDioService(
      () async => await dio.get(
        'auth/me/',
        options: super.getBaseOptions(accessToken)
      )
    );
    final result = response.data;
    return User(
      name: result['nombre_completo'],
      role: result['rol'],
      image: result['foto']
    );
  }
}