import 'package:quadycons/core/repository_error_handler.dart';
import 'package:quadycons/data/db/daos/attendance_dao.dart';
import 'package:quadycons/data/db/mappers/attendance_mapper.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/services/mappers/registration_result_mapper.dart';
import 'package:quadycons/data/services/synchronization_service.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/registration_result.dart';
import 'package:quadycons/domain/exceptions.dart';
import 'package:quadycons/domain/repositories/synchronization_repository.dart';

class SynchronizationRepositoryImpl implements SynchronizationRepository {
  
  final AttendanceDao attendanceDao;
  final AccessTokenGetter accessTokenGetter;
  final SynchronizationService service;
  final ConnectivityService connectivity;
  final RepositoryErrorHandler errorHandler;

  SynchronizationRepositoryImpl({
    required this.attendanceDao,
    required this.accessTokenGetter,
    required this.service,
    required this.connectivity,
    required this.errorHandler
  });

  @override
  Future<List<PendingRegistration>> getLastRegistrations(List<Project> projects) async {
    final pendingAttendances = await attendanceDao.getTodayWithWorker();
    return AttendanceMapper.getRegistrationsFromDb(pendingAttendances, projects);
  }

  @override
  Future<List<RegistrationResult>> synchronize(List<PendingRegistration> registrations) async => await errorHandler.executeFunction(() async {
    if(!(await connectivity.thereIsConnectivity())) {
      throw GeneralException(message: 'No hay conexión a internet');
    }
    final accessToken = await accessTokenGetter.getAccessToken();
    final results = await service.synchronize(registrations, accessToken);
    return results.map(
      (r) => RegistrationResultMapper.toDomain(r)
    ).toList();
  });
  
  @override
  Future<void> markAsSynchronized(List<PendingRegistration> registrations) async {
    for(final registration in registrations) {
      if(registration.registration.type == .checkIn) {
        var rawAttendance = await attendanceDao.getById(
          registration.localAttendanceId
        );
        final attendance = AttendanceMapper.fromDb(
          rawAttendance
        ).copyWith(
          remoteId: registration.remoteAttendanceId!
        );
        final attendanceCompanion = AttendanceMapper.toDb(
          attendance
        );
        await attendanceDao.updateAttendance(
          registration.localAttendanceId,
          attendanceCompanion
        );
        if(attendance.checkout == null) {
          await attendanceDao.changeSynced(
            localId: registration.localAttendanceId,
            synced: true
          );
        }
      } else {
        await attendanceDao.changeSynced(
          localId: registration.localAttendanceId,
          synced: true
        );
      }
    }
  }
  
  @override
  Future<void> removeRegistrations(List<int> attendancesIds) async {
    for(final id in attendancesIds) {
      await attendanceDao.deleteAttendanceById(
        id
      );
    }
  }
  
  @override
  Future<void> updateRegistrations(List<PendingRegistration> registrations) async {
    for(final r in registrations) {
      final daoAttendance = await attendanceDao.getById(
        r.localAttendanceId
      );
      var attendance = AttendanceMapper.fromDb(
        daoAttendance
      );
      if(r.registration.type == .checkIn) {
        attendance = attendance.copyWith(
          checkin: r.registration.check
        );
      } else if(r.registration.type == .checkOut) {
        attendance = attendance.copyWith(
          checkout: r.registration.check
        );
      }
      final attendanceCompanion = AttendanceMapper.toDb(
        attendance
      );
      await attendanceDao.updateAttendance(
        r.localAttendanceId,
        attendanceCompanion
      );
    }
  }
}