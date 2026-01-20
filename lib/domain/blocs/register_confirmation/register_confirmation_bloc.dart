import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/register_type.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/domain/repositories/attendance_repository.dart';

part 'register_confirmation_event.dart';
part 'register_confirmation_state.dart';

class RegisterConfirmationBloc extends Bloc<RegisterConfirmationEvent, RegisterConfirmationState> {
  
  final AttendanceRepository repository;
    
  RegisterConfirmationBloc({
    required this.repository
  }) : super(RegisterConfirmationInitial()) {
    on<InitRegistrationConfirmation>(_onInitRegistrationConfirmation);
    on<ConfirmRegistration>(_onConfirmRegistration);
  }

  Future<void> _onInitRegistrationConfirmation(
    InitRegistrationConfirmation event,
    Emitter<RegisterConfirmationState> emit
  ) async {
    final attendance = await repository.getAttendanceByUserDoc(event.registration.idCodeInfo.docNumber);
    final registerType = event.registration.type;
    if(registerType == RegisterType.input) {
      if(attendance != null) {
        emit(OnRegistration(
          attendance: attendance,
          registerType: registerType,
          error: RegisterConfirmError(
            message: 'Registro duplicado (Ya existe entrada)',
            type: RegisterConfirmErrorType.inconsistentAttendance
          )
        ));
      } else {
        emit(OnRegistration(
          attendance: Attendance(
            checkin: event.registration.check,
            checkout: null,
            idCodeInfo: event.registration.idCodeInfo
          ),
          registerType: registerType
        ));
      }
    } else if(attendance == null) {
      emit(OnRegistration(
        attendance: Attendance(
          checkin: null,
          checkout: event.registration.check,
          idCodeInfo: event.registration.idCodeInfo
        ),
        registerType: registerType,
        error: RegisterConfirmError(
            message: 'No existe registro de entrada previo',
            type: RegisterConfirmErrorType.inconsistentAttendance
          )
      ));
    } else {
      emit(OnRegistration(
        attendance: attendance.copyWith(
          checkout: event.registration.check
        ),
        registerType: registerType
      ));
    }
  }

  Future<void> _onConfirmRegistration(ConfirmRegistration event, Emitter<RegisterConfirmationState> emit
  ) async {
    final initState = state as OnRegistration;
    emit(initState.copyWith(isLoading: true));
    try{
      Attendance updatedAttendance;
      final registerType = initState.registerType;
      if(registerType == RegisterType.input) {
        updatedAttendance = await repository.confirmCheckIn(Registration(
          check: initState.attendance.checkin!,
          idCodeInfo: initState.attendance.idCodeInfo,
          type: registerType
        ));
      } else {
        updatedAttendance = await repository.confirmCheckOut(initState.attendance);
      }
      emit(initState.copyWith(
        isLoading: false,
        registration: updatedAttendance,
        confirmed: true
      ));
    } catch (e) {
      emit(initState.copyWith(
        isLoading: false,
        error: RegisterConfirmError(
          message: e.toString(),
          type: RegisterConfirmErrorType.general
        )
      ));
    }
    
  }
}
