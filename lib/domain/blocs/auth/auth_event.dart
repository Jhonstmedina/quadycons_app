part of 'auth_bloc.dart';
abstract class AuthEvent{
  
}

class InitLoginEvent extends AuthEvent{

}

class LoginEvent extends AuthEvent{
  final String userName;
  final String password;
  LoginEvent(this.userName, this.password);
}

class LogoutEvent extends AuthEvent{

}