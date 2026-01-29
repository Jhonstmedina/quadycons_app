import 'package:quadycons/data/db/app_database.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/domain/entities/authentication.dart';
import 'package:quadycons/domain/entities/user.dart';
import 'package:quadycons/data/local_data_source/auth_local_data_source.dart';
import 'package:quadycons/data/services/auth_service.dart';
import 'package:quadycons/domain/exceptions.dart';
import 'package:quadycons/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  final AuthLocalDataSource localDataSource;
  final DataBaseCleaner dbCleaner;
  final ConnectivityService connectivityService;

  AuthRepositoryImpl({
    required this.authService,
    required this.localDataSource,
    required this.dbCleaner,
    required this.connectivityService
  });

  @override
  Future<void> login(Authentication auth) async {
    if(!(await connectivityService.thereIsConnectivity())) {
      throw GeneralException(message: 'No hay conectividad');
    }
    final token = await authService.login(auth);
    await localDataSource.cacheAuthToken(token);
  }
  
  @override
  Future<void> logout() async {
    try {
      final accessToken = await localDataSource.getAccessToken();
      await authService.logout(accessToken);
      if(! await connectivityService.thereIsConnectivity() ) {
        throw GeneralException(message: 'No hay conectividad');
      }
      await localDataSource.removeAuthToken();
      await dbCleaner.clearDatabase();
    } on GeneralException {
      rethrow;
    } catch ( e ) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<User?> getUser() async {
    String accessToken;
    try {
      accessToken = await localDataSource.getAccessToken();
      if(accessToken.isEmpty) {
        return null;
      }
    } catch (_) {
      return null;
    }
    late User? user;
    if(await connectivityService.thereIsConnectivity()) {
      user = await authService.getUser(accessToken);
      await localDataSource.saveUser(user);
    } else {
      user = await localDataSource.getUser();
    }
    return user;
  }
}