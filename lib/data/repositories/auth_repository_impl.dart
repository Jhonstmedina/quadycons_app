import 'package:quadycons/data/entities/authentication.dart';
import 'package:quadycons/data/entities/user.dart';
import 'package:quadycons/data/local_data_source/auth_local_data_source.dart';
import 'package:quadycons/data/services/auth_service.dart';
import 'package:quadycons/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.authService,
    required this.localDataSource
  });

  @override
  Future<void> login(Authentication auth) async {
    final token = await authService.login(auth);
    await localDataSource.cacheAuthToken(token);
  }
  
  @override
  Future<void> logout() async {
    await localDataSource.removeAuthToken();
  }

  @override
  Future<User?> getUser() async {
    String accessToken;
    try {
      accessToken = await localDataSource.getAccessToken();
    } catch (_) {
      return null;
    }
    final user = await authService.getUser(accessToken);
    await localDataSource.saveUser(user);
    return user;
  }
}