import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/platform/storage_connector.dart';

class AuthLocalDataSource implements AccessTokenGetter{

  static const authTokenKey = 'auth_token';

  final StorageConnector storageConnector;
  AuthLocalDataSource({required this.storageConnector});

  Future<void> cacheAuthToken(String token) async {
    await storageConnector.setString(token, authTokenKey);
  }

  Future<void> removeAuthToken() async {
    await storageConnector.remove(authTokenKey);
  }
  
  @override
  Future<String> getAccessToken() async {
    return await storageConnector.getString(authTokenKey);
  }
}