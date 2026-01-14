part of 'register_confirmation_bloc.dart';

@immutable
sealed class RegisterConfirmationState {}

final class RegisterConfirmationInitial extends RegisterConfirmationState {}

final class OnRegistration extends RegisterConfirmationState {
  final Registration registration;
  final bool confirmed;
  final bool isLoading;
  final String? errorMessage;

  OnRegistration({
    required this.registration,
    this.confirmed = false,
    this.isLoading = false,
    this.errorMessage,
  });

  OnRegistration copyWith({
    Registration? registration,
    bool? confirmed,
    bool? isLoading,
    String? errorMessage
  }) => OnRegistration(
    registration: registration ?? this.registration,
    confirmed: confirmed ?? this.confirmed,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage
  );
}
