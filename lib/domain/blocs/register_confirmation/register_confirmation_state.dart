part of 'register_confirmation_bloc.dart';

@immutable
sealed class RegisterConfirmationState {}

final class RegisterConfirmationInitial extends RegisterConfirmationState {}

enum RegisterConfirmErrorType {
  general,
  inconsistentAttendance
}

class RegisterConfirmError {
  final String message;
  final RegisterConfirmErrorType type;

  RegisterConfirmError({
    required this.message,
    this.type = RegisterConfirmErrorType.general
  });
}

final class OnRegistration extends RegisterConfirmationState {
  final Attendance attendance;
  final bool confirmed;
  final bool isLoading;
  final RegisterConfirmError? error;
  final RegisterType registerType;

  OnRegistration({
    required this.attendance,
    this.confirmed = false,
    this.isLoading = false,
    this.error,
    required this.registerType
  });

  OnRegistration copyWith({
    Attendance? registration,
    bool? confirmed,
    bool? isLoading,
    RegisterType? registerType,
    RegisterConfirmError? error
  }) => OnRegistration(
    attendance: registration ?? this.attendance,
    confirmed: confirmed ?? this.confirmed,
    isLoading: isLoading ?? this.isLoading,
    registerType: registerType ?? this.registerType,
    error: error
  );
}
