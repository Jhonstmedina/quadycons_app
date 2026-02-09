import 'dart:convert';

import 'package:quadycons/domain/entities/authentication.dart';
import 'package:quadycons/domain/entities/user.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/platform/storage_connector.dart';

class AuthLocalDataSource implements AccessTokenGetter{

  static const authKey = 'auth';
  static const authTokenKey = 'auth_token';
  static const userKey = 'user';

  final StorageConnector storageConnector;
  AuthLocalDataSource({required this.storageConnector});

  Future<void> cacheAuthToken(String token) async {
    await storageConnector.setString(token, authTokenKey);
  }

  Future<void> removeAuthToken() async {
    await storageConnector.remove(authTokenKey);
  }

  Future<void> saveUser(User user) async {
    final jsonUser = {
      'name': user.name,
      'rol': user.role,
      'image': user.image
    };
    await storageConnector.setString(
      jsonEncode(jsonUser),
      userKey
    );
  }

  Future<User?> getUser() async {
    final userJson = await storageConnector.getString(userKey);
    final Map<String, dynamic> userMap = jsonDecode(userJson);
    return User(
      name: userMap['name'],
      role: userMap['rol'],
      image: userMap['image']
    );
  }

  Future<void> saveAuth(Authentication auth) async {
    final json = {
      'email': auth.userName,
      'password': auth.password
    };
    await storageConnector.setString(
      jsonEncode(json),
      authKey
    );
  }

  Future<Authentication> getAuth() async {
    final authJson = await storageConnector.getString(authKey);
    final Map<String, dynamic> authMap = jsonDecode(authJson);
    return Authentication(
      userName: authMap['email'],
      password: authMap['password']
    );
  }

  Future<void> removeAuth() async {
    await storageConnector.remove(authKey);
  }
  
  @override
  Future<String> getAccessToken() async {
    return await storageConnector.getString(authTokenKey);
  }
}