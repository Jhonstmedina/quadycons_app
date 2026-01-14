part of 'register_confirmation_bloc.dart';

@immutable
sealed class RegisterConfirmationEvent {}

final class InitRegistrationConfirmation extends RegisterConfirmationEvent {
  final Registration registration;
  InitRegistrationConfirmation({required this.registration});
}

final class ConfirmRegistration extends RegisterConfirmationEvent {
  ConfirmRegistration();
}
