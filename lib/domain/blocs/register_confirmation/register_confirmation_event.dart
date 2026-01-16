part of 'register_confirmation_bloc.dart';

@immutable
sealed class RegisterConfirmationEvent {}

final class InitRegistrationConfirmation extends RegisterConfirmationEvent {
  final Attendance registration;
  InitRegistrationConfirmation({required this.registration});
}

final class ConfirmRegistration extends RegisterConfirmationEvent {
  final Project project;
  ConfirmRegistration({required this.project});
}
