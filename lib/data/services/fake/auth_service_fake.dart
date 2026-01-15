import 'package:quadycons/data/entities/authentication.dart';
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
}