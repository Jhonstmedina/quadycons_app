part of 'synchronization_bloc.dart';

@immutable
sealed class SynchronizationEvent {}

final class GetPendingRegistrations extends SynchronizationEvent {

}

final class Synchronize extends SynchronizationEvent {

}