import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/repositories/synchronization_repository.dart';
import 'package:quadycons/domain/use_cases/clean_last_registrations.dart';
import 'package:quadycons/domain/use_cases/synchronize.dart';

part 'synchronization_event.dart';
part 'synchronization_state.dart';

class SynchronizationBloc extends Bloc<SynchronizationEvent, SynchronizationState> {
  
  final SynchronizationRepository repository;
  final Synchronize synchronize;
  final CleanLastRegistrations cleanLastRegistrations;

  SynchronizationBloc({
    required this.repository,
    required this.synchronize,
    required this.cleanLastRegistrations
  }) : super(SynchronizationInitial()) {
    on<GetLastRegistrationsEvent>(_getPendingRegistrations);
    on<SynchronizeRegistrationsEvent>(_synchronizeRegistrations);
    on<CleanLastRegistrationsEvent>(_cleanLastRegistrations);
  }

  Future<void> _getPendingRegistrations(GetLastRegistrationsEvent event, Emitter<SynchronizationState> emit) async {  
    final lastRegistrations = await repository.getPendingRegistrations(event.projects);
    emit(LastRegistrationsLoaded(
      lastRegistrations: lastRegistrations,
      canSynchronize: lastRegistrations.any(
        (r) => r.status == .pending
      )
    ));
  }

  Future<void> _synchronizeRegistrations(SynchronizeRegistrationsEvent event, Emitter<SynchronizationState> emit) async {
    final initState = state;
    if(initState is! LastRegistrationsLoaded || !initState.canSynchronize) return;
    emit(initState.copyWith(
      isLoading: true
    ));
    final registrations = await synchronize(initState.lastRegistrations, event.projects);
    emit(initState.copyWith(
      isLoading: false,
      lastRegistrations: registrations,
      canSynchronize: registrations.any(
        (r) => r.status == .pending
      )
    ));
  }

  Future<void> _cleanLastRegistrations(CleanLastRegistrationsEvent event, Emitter<SynchronizationState> emit) async {
    final initState = state;
    if(initState is! LastRegistrationsLoaded) return;
    final remainingRegistrations = await cleanLastRegistrations(initState.lastRegistrations, event.projects);
    emit(initState.copyWith(
      lastRegistrations: remainingRegistrations,
      canSynchronize: remainingRegistrations.any(
        (r) => r.status == .pending
      )
    ));
  }
}
