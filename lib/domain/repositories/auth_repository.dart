import 'package:quadycons/domain/entities/authentication.dart';
import 'package:quadycons/domain/entities/user.dart';

abstract class AuthRepository{
  Future<void> login(Authentication auth);
  Future<void> logout();
  Future<User?> getUser();
}