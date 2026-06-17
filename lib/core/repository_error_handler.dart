import 'package:quadycons/core/auth_fixer.dart';
import 'package:quadycons/domain/exceptions.dart';

abstract class RepositoryErrorHandler{
  Future<N> executeFunction<N>(Future<N> Function() function);
}

class RepositoryErrorHandlerImpl implements RepositoryErrorHandler{
  final AuthFixer authFixer;
  const RepositoryErrorHandlerImpl({
    required this.authFixer
  });

  @override
  Future<N> executeFunction<N>(Future<N> Function() function)async{
    try{
      return await function();
    }on GeneralException catch(exception){
      if(exception is ServerException && exception.statusCode == ServerException.unauthorizedStatus){
        try {
          await authFixer.reLogin();
          return await function();
        } catch (reLoginException) {
          // Si falla el reLogin, no reintentar y propagar el error
          rethrow;
        }
      }
      rethrow;
    }
  }
}