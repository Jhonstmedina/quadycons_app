import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/data/entities/attendance.dart';
import 'package:quadycons/data/entities/project.dart';
import 'package:quadycons/domain/repositories/register_confirmation_repository.dart';

part 'register_confirmation_event.dart';
part 'register_confirmation_state.dart';

class RegisterConfirmationBloc extends Bloc<RegisterConfirmationEvent, RegisterConfirmationState> {
  
  final RegisterConfirmationRepository repository;
    
  RegisterConfirmationBloc({
    required this.repository
  }) : super(RegisterConfirmationInitial()) {
    on<InitRegistrationConfirmation>(_onInitRegistrationConfirmation);
    on<ConfirmRegistration>(_onConfirmRegistration);
  }

  void _onInitRegistrationConfirmation(
    InitRegistrationConfirmation event,
    Emitter<RegisterConfirmationState> emit
  ) {
    emit(OnRegistration(
      registration: event.registration
    ));
  }

  Future<void> _onConfirmRegistration(ConfirmRegistration event, Emitter<RegisterConfirmationState> emit
  ) async {
    final initState = state as OnRegistration;
    emit(initState.copyWith(isLoading: true));
    try{
      final registration = await repository.confirmRegistration(initState.registration);
      emit(initState.copyWith(
        isLoading: false,
        registration: registration,
        confirmed: true
      ));
    } catch (e) {
      emit(initState.copyWith(
        isLoading: false,
        errorMessage: e.toString()
      ));
    }
    
  }
}
