part of 'auth_bloc.dart';

enum LoginErrorType{
  emptyUserName,
  emptyPassword,
  emptyCode
}

abstract class AuthState{

}

class LoginInit extends AuthState {
  
}

class OnLogin extends AuthState{
  final bool loading;
  final String? errorMessage;
  final String? emailMessage;
  final String? passwordMessage;

  OnLogin({
    this.loading = false,
    this.errorMessage,
    this.emailMessage,
    this.passwordMessage
  });

  OnLogin copyWith({
    bool? loading,
    String? errorMessage,
    String? emailMessage,
    String? passwordMessage
  }) =>  OnLogin(
    loading: loading ?? this.loading,
    errorMessage: errorMessage,
    emailMessage: emailMessage,
    passwordMessage: passwordMessage
  );
}

class OnAuthenticated extends AuthState{
  final bool loading;
  final String? errorMessage;
  final User? user;
  OnAuthenticated({
    this.loading = false,
    this.errorMessage,
    this.user
  });
  OnAuthenticated copyWith({
    bool? loading,
    String? errorMessage,
    User? user
  }) => OnAuthenticated(
    loading: loading ?? this.loading,
    errorMessage: errorMessage,
    user: user ?? this.user
  );
}

class OnUnAuthenticated extends AuthState{
  
}