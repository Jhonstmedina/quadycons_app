import 'package:quadycons/data/entities/attendance.dart';
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
  Future<Attendance> confirmRegistration(Attendance registration) async {
    final accessToken = await accessTokenGetter.getAccessToken();
    return await registerConfirmationService.confirmRegistration(
      registration,
      accessToken
    );
  }

  @override
  Future<Attendance> confirmCheckIn(Registration registration) async {
    final accessToken = await accessTokenGetter.getAccessToken();
    return await registerConfirmationService.confirmCheckIn(
      registration,
      accessToken
    );
  }

  @override
  Future<Attendance> confirmCheckOut(Attendance attendance) async {
    final accessToken = await accessTokenGetter.getAccessToken();
    return await registerConfirmationService.confirmCheckOut(
      attendance,
      accessToken
    );
  }
}