import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/repositories/synchronize_repository.dart';

part 'synchronization_event.dart';
part 'synchronization_state.dart';

class SynchronizationBloc extends Bloc<SynchronizationEvent, SynchronizationState> {
  
  final SynchronizeRepository repository;

  SynchronizationBloc({
    required this.repository
  }) : super(SynchronizationInitial()) {
    on<GetPendingRegistrations>(_getPendingRegistrations);
  }

  Future<void> _getPendingRegistrations(_, Emitter<SynchronizationState> emit) async {  
    final pending = await repository.getPendingRegistrations();
    emit(PendingRegistrationsLoaded(pendingRegistrations: pending));
  }
}
