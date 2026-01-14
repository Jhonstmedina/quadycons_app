import 'package:quadycons/data/entities/authentication.dart';
import 'package:quadycons/data/services/service.dart';

abstract class AuthService {
  Future<String> login(Authentication auth);
}

class AuthServiceImpl extends Service implements AuthService {
  AuthServiceImpl({required super.dio});

  @override
  Future<String> login(Authentication auth) async {
    // TODO: implement login
    throw UnimplementedError();
  }
  
}