import 'package:quadycons/data/entities/authentication.dart';

abstract class AuthRepository{
  Future<void> login(Authentication auth);
  Future<void> logout();
}