import 'package:quadycons/data/entities/authentication.dart';
import 'package:quadycons/data/entities/user.dart';

abstract class AuthRepository{
  Future<void> login(Authentication auth);
  Future<void> logout();
  Future<User?> getUser();
}