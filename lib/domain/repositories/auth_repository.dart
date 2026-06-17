import 'package:quadycons/core/auth_fixer.dart';
import 'package:quadycons/domain/entities/authentication.dart';

abstract class AuthRepository extends AuthFixer{
  Future<void> login(Authentication auth);
  Future<void> logout();
}