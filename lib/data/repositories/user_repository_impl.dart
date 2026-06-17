import 'package:quadycons/core/repository_error_handler.dart';
import 'package:quadycons/data/local_data_source/auth_local_data_source.dart';
import 'package:quadycons/data/services/auth_service.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/domain/entities/user.dart';
import 'package:quadycons/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final AuthLocalDataSource authLocalDataSource;
  final AuthService authService;
  final ConnectivityService connectivityService;
  final RepositoryErrorHandler errorHandler;

  UserRepositoryImpl({
    required this.authLocalDataSource,
    required this.authService,
    required this.connectivityService,
    required this.errorHandler
  });

  @override
  Future<User?> getUser() async => await errorHandler.executeFunction(() async {
    String accessToken;
    try {
      accessToken = await authLocalDataSource.getAccessToken();
      if(accessToken.isEmpty) {
        return null;
      }
    } catch (_) {
      return null;
    }
    late User? user;
    if(await connectivityService.thereIsConnectivity()) {
      user = await authService.getUser(accessToken);
      await authLocalDataSource.saveUser(user);
    } else {
      user = await authLocalDataSource.getUser();
    }
    return user;
  });

}