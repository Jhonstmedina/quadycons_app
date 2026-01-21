part of 'synchronization_bloc.dart';

@immutable
sealed class SynchronizationState {}

final class SynchronizationInitial extends SynchronizationState {}

final class PendingRegistrationsLoaded extends SynchronizationState {
  final List<PendingRegistration> pendingRegistrations;
  final bool isLoading;

  PendingRegistrationsLoaded({
    required this.pendingRegistrations,
    this.isLoading = false,
  });

  PendingRegistrationsLoaded copyWith({
    List<PendingRegistration>? pendingRegistrations,
    bool? isLoading,
  }) => PendingRegistrationsLoaded(
    pendingRegistrations: pendingRegistrations ?? this.pendingRegistrations,
    isLoading: isLoading ?? this.isLoading,
  );
}
