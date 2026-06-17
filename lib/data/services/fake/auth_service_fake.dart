import 'package:quadycons/domain/entities/authentication.dart';
import 'package:quadycons/domain/entities/user.dart';
import 'package:quadycons/data/services/auth_service.dart';

class AuthServiceFake implements AuthService {
  
  @override
  Future<String> login(Authentication auth) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'new_access_token';
  }
  
  @override
  Future<void> logout(String accessToken) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<User> getUser(String accessToken) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(
      name: 'Fake User',
      role: 'Supervisor',
      image: 'https://media.istockphoto.com/id/2014684899/es/vector/avatar-de-marcador-de-posici%C3%B3n-imagen-de-avatar-de-mujer-predeterminada-de-persona-femenina.jpg?s=612x612&w=0&k=20&c=rn1Axer2evcd80qgLR-C8SYFkwTysvcPBK7iKEi6Du4='
    );
  }
  
  @override
  Future<void> reLogin(String accessToken) async {
    // TODO: implement reLogin
    throw UnimplementedError();
  }
}