part of 'auth_bloc.dart';

enum LoginErrorType{
  emptyUserName,
  emptyPassword,
  emptyCode
}

abstract class AuthState{

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
  OnAuthenticated({
    this.loading = false,
    this.errorMessage
  });
  OnAuthenticated copyWith({
    bool? loading,
    String? errorMessage
  }) => OnAuthenticated(
    loading: loading ?? this.loading,
    errorMessage: errorMessage
  );
}

class OnUnAuthenticated extends AuthState{
  
}