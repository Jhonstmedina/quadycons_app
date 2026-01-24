part of 'synchronization_bloc.dart';

@immutable
sealed class SynchronizationEvent {}

final class GetLastRegistrationsEvent extends SynchronizationEvent {
  final List<Project> projects;

  GetLastRegistrationsEvent(this.projects);
}

final class SynchronizeRegistrationsEvent extends SynchronizationEvent {
  final List<Project> projects;
  SynchronizeRegistrationsEvent({
    required this.projects
  });
}

final class CleanLastRegistrationsEvent extends SynchronizationEvent {
  final List<Project> projects;
  CleanLastRegistrationsEvent(this.projects);
}