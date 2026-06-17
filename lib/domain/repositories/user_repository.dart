import 'package:quadycons/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUser();
}
