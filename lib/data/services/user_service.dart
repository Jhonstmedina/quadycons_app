import 'package:dio/dio.dart';
import 'package:quadycons/data/entities/user.dart';
import 'package:quadycons/data/services/service.dart';

abstract class UserService {
  Future<User> getUser(String accessToken);
}

class UserServiceImpl extends Service implements UserService {
  UserServiceImpl({required super.dio});

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