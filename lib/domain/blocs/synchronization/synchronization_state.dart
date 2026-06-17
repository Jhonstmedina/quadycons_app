part of 'synchronization_bloc.dart';

@immutable
sealed class SynchronizationState {}

final class SynchronizationInitial extends SynchronizationState {}

final class LastRegistrationsLoaded extends SynchronizationState {
  final List<PendingRegistration> lastRegistrations;
  final bool canSynchronize;
  final bool isLoading;

  LastRegistrationsLoaded({
    required this.lastRegistrations,
    this.isLoading = false,
    required this.canSynchronize
  });

  LastRegistrationsLoaded copyWith({
    List<PendingRegistration>? lastRegistrations,
    bool? isLoading,
    bool? canSynchronize
  }) => LastRegistrationsLoaded(
    lastRegistrations: lastRegistrations ?? this.lastRegistrations,
    isLoading: isLoading ?? this.isLoading,
    canSynchronize: canSynchronize ?? this.canSynchronize
  );
}
