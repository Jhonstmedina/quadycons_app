import 'package:bloc/bloc.dart';
import 'package:quadycons/data/entities/authentication.dart';
import 'package:quadycons/data/entities/user.dart';
import 'package:quadycons/domain/repositories/auth_repository.dart';
import 'package:quadycons/domain/exceptions.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  static const defaultErrorMessage = 'Ha ocurrido un error inesperado';
  static const emptyUserNameErrorMessage = 'El campo de usuario no puede estar vacío';
  static const emptyPasswordErrorMessage = 'El campo de contraseña no puede estar vacío';
  static const emptyCodeErrorMessage = 'El campo de código está vacío';
  static const invalidCredentialsErrorMessage = 'Credenciales Inválidas';

  final AuthRepository repository;
  
  AuthBloc({
    required this.repository
  }) : super(LoginInit()){
    on<InitLoginEvent>(_initLogin);
    on<LoginEvent>(_login);
    on<LogoutEvent>(_logout);
  }

  Future<void> _initLogin(_, Emitter<AuthState> emit) async {
    final user = await repository.getUser();
    if(user == null) {
      emit(OnLogin());
    } else {
      emit(OnAuthenticated(user: user));
    }
  }  

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit)async{
    final initState = state as OnLogin;
    emit(initState.copyWith(loading: true));
    final auth = Authentication(
      userName: event.userName,
      password: event.password
    );
    try{
      if(auth.userName.isEmpty){
        emit(OnLogin(
          emailMessage: emptyUserNameErrorMessage
        ));
      }else if(auth.password.isEmpty){
        emit(OnLogin(
          passwordMessage: emptyPasswordErrorMessage
        ));
      }else{
        await repository.login(auth);
        final user = await repository.getUser();
        emit(OnAuthenticated(user: user));
      }
    } on GeneralException catch(exception){
      emit(OnLogin(
        errorMessage: exception.message,
        emailMessage: null,
        passwordMessage: null
      ));
    }
  }

  Future<void> _logout(_, Emitter<AuthState> emit)async{
    final initState = state as OnAuthenticated;
    emit(initState.copyWith(loading: true));
    try{
      await repository.logout();
      emit(OnUnAuthenticated());
    }on GeneralException catch(exception){
      emit(OnAuthenticated(
        errorMessage: exception.message
      ));
    }
  }
}