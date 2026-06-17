part of 'register_confirmation_bloc.dart';

@immutable
sealed class RegisterConfirmationEvent {}

final class InitRegistrationConfirmation extends RegisterConfirmationEvent {
  final Registration registration;
  final List<Project> projects;
  InitRegistrationConfirmation({required this.registration, required this.projects});
}

final class ConfirmRegistration extends RegisterConfirmationEvent {
  final Project project;
  ConfirmRegistration({required this.project});
}
