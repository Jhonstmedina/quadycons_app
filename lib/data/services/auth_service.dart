import 'package:dio/dio.dart';
import 'package:quadycons/data/entities/authentication.dart';
import 'package:quadycons/data/entities/user.dart';
import 'package:quadycons/data/services/service.dart';

abstract class AuthService {
  Future<String> login(Authentication auth);
  Future<void> logout(String accessToken);
  Future<User> getUser(String accessToken);
}

class AuthServiceImpl extends Service implements AuthService {
  
  
  AuthServiceImpl({required super.dio});

  @override
  Future<String> login(Authentication auth) async {
    final response = await dio.post(
      'auth/login',
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
  }
  
  @override
  Future<void> logout(String accessToken) async {
    await dio.post(
      'auth/logout',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        }
      )
    );
  }
  
  @override
  Future<User> getUser(String accessToken) async {
    final response = await super.executeDioService(
      () async => await dio.get(
        'auth/me/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          }
        )
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