import 'package:quadycons/data/entities/registration.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/services/register_confirmation_service.dart';
import 'package:quadycons/domain/repositories/register_confirmation_repository.dart';

class RegisterConfirmationRepositoryImpl implements RegisterConfirmationRepository {
  final RegisterConfirmationService registerConfirmationService;
  final AccessTokenGetter accessTokenGetter;

  RegisterConfirmationRepositoryImpl({
    required this.registerConfirmationService,
    required this.accessTokenGetter,
  });

  @override
  Future<Registration> confirmRegistration(Registration registration) async {
    final token = await accessTokenGetter.getAccessToken();
    return await registerConfirmationService.confirmRegistration(registration, token);
  }
}