// lib/domain/blocs/register_confirmation/register_confirmation_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/register_type.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/domain/exceptions.dart';
import 'package:quadycons/domain/repositories/attendance_repository.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';

part 'register_confirmation_event.dart';
part 'register_confirmation_state.dart';

class RegisterConfirmationBloc extends Bloc<RegisterConfirmationEvent, RegisterConfirmationState> {
  
  final AttendanceRepository repository;
  final ConnectivityService connectivityService;
    
  RegisterConfirmationBloc({
    required this.repository,
    required this.connectivityService
  }) : super(RegisterConfirmationInitial()) {
    on<InitRegistrationConfirmation>(_onInitRegistrationConfirmation);
    on<ConfirmRegistration>(_onConfirmRegistration);
  }

  Future<void> _onInitRegistrationConfirmation(
    InitRegistrationConfirmation event,
    Emitter<RegisterConfirmationState> emit
  ) async {
    final registerType = event.registration.type;
    final isOnline = await connectivityService.thereIsConnectivity();

    if (isOnline) {
      // ONLINE: no validar localmente, dejar que el servidor decida
      if (registerType == RegisterType.checkIn) {
        emit(OnRegistration(
          attendance: Attendance(
            checkin: event.registration.check,
            checkout: null,
            idCodeInfo: event.registration.idCodeInfo
          ),
          registerType: registerType
        ));
      } else {
        // Para check-out intentamos buscar el attendance local
        final attendance = await repository.getAttendanceByUserDoc(
          event.registration.idCodeInfo.docNumber, event.projects
        );
        if (attendance == null) {
          // Ya no bloqueamos con error si estamos ONLINE
          emit(OnRegistration(
            attendance: Attendance(
              checkin: null,
              checkout: event.registration.check,
              idCodeInfo: event.registration.idCodeInfo
            ),
            registerType: registerType
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
    } else {
      // OFFLINE: validar contra base local obligatoriamente
      final attendance = await repository.getAttendanceByUserDoc(
        event.registration.idCodeInfo.docNumber, event.projects
      );
      if (registerType == RegisterType.checkIn) {
        if (attendance != null && attendance.checkin != null) {
          final hora = '${attendance.checkin!.time.hour.toString().padLeft(2, '0')}:${attendance.checkin!.time.minute.toString().padLeft(2, '0')}';
          emit(OnRegistration(
            attendance: attendance,
            registerType: registerType,
            error: RegisterConfirmError(
              message: 'Este trabajador ya tiene un check-in ($hora) registrado. Conéctate a internet y sincroniza para alinearte con el servidor.',
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
      } else if (attendance == null) {
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
      } else if (attendance.checkout != null) {
        final hora = '${attendance.checkout!.time.hour.toString().padLeft(2, '0')}:${attendance.checkout!.time.minute.toString().padLeft(2, '0')}';
        emit(OnRegistration(
          attendance: attendance,
          registerType: registerType,
          error: RegisterConfirmError(
            message: 'Este trabajador ya tiene un check-out ($hora) registrado. Conéctate a internet y sincroniza para alinearte con el servidor.',
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
  }

  Future<void> _onConfirmRegistration(ConfirmRegistration event, Emitter<RegisterConfirmationState> emit
  ) async {
    final initState = state as OnRegistration;
    emit(initState.copyWith(isLoading: true));
    try{
      Attendance updatedAttendance;
      final registerType = initState.registerType;
      if(registerType == RegisterType.checkIn) {
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
          message: e is GeneralException? e.message : e.toString(),
          type: RegisterConfirmErrorType.general
        )
      ));
    }
    
  }
}
