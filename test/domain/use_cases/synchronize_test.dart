import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/domain/entities/registration_result.dart';
import 'package:quadycons/domain/entities/registration_status.dart';
import 'package:quadycons/domain/repositories/synchronization_repository.dart';
import 'package:quadycons/domain/use_cases/synchronize.dart';

import 'synchronize_test.mocks.dart';

@GenerateMocks([SynchronizationRepository])
void main() {
  late SynchronizeImpl synchronizeImpl;
  late MockSynchronizationRepository mockRepository;
  late List<Project> projects;

  setUp(() {
    mockRepository = MockSynchronizationRepository();
    synchronizeImpl = SynchronizeImpl(repository: mockRepository);
    projects = [];
  });

  group('SynchronizeImpl', () {
    test('Debe actualizar el estado de la misma lista de registrations inicial cuando todos los registros se sincronizaron', () async {
      final todayRegistrations = [
        // Primer par: checkIn con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 1,
          status: .pending
        ),
        // Primer par: checkOut con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 17, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 1,
          status: .pending
        )
      ];

      // arrange
      final mockSynchronizeResponse = [
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkOut
        ),
      ];
      
      when(mockRepository.synchronize(any))
          .thenAnswer((_) async => mockSynchronizeResponse);
      when(mockRepository.markAsSynchronized(any))
          .thenAnswer((_) async => {});
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => []);
      
      // act
      await synchronizeImpl.call(todayRegistrations, projects);
      
      // assert
      verify(mockRepository.synchronize(todayRegistrations)).called(1);
      // Se verifica que se haya llamado a markAsSynchronized con las registrations actualizadas
      verify(mockRepository.markAsSynchronized(
        argThat(
          predicate<List<PendingRegistration>>(
            (list){
              for(int i = 0; i < list.length; i++) {
                if(
                  list[i].localAttendanceId != todayRegistrations[i].localAttendanceId ||
                  list[i].registration.type != todayRegistrations[i].registration.type ||
                  list[i].remoteAttendanceId != mockSynchronizeResponse[i].remoteAttendanceId ||
                  list[i].status != RegistrationStatus.completed
                ) {
                  return false;
                }
              }
              return true;
            }
              
          )
        )
      )).called(1);
      
    });

    test('Debe sincronizar únicamente los registros que estén pendientes', () async {
      final todayRegistrations = [
        // Primer par: checkIn con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 1,
          status: .completed
        ),
        // Primer par: checkOut con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 17, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .pending
        )
      ];

      // arrange
      final mockSynchronizeResponse = [
        RegistrationResult(
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkOut
        ),
      ];
      
      when(mockRepository.synchronize(any))
          .thenAnswer((_) async => mockSynchronizeResponse);
      when(mockRepository.markAsSynchronized(any))
          .thenAnswer((_) async => {});
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => []);
      
      // act
      await synchronizeImpl.call(todayRegistrations, projects);
      
      // assert
      verify(mockRepository.synchronize([todayRegistrations[1]])).called(1);
            // Se verifica que se haya llamado a markAsSynchronized con las registrations actualizadas
      verify(mockRepository.markAsSynchronized(
        argThat(
          predicate<List<PendingRegistration>>(
            (list){
              if(
                list[0].localAttendanceId != todayRegistrations[1].localAttendanceId ||
                list[0].registration.type != todayRegistrations[1].registration.type ||
                list[0].remoteAttendanceId != mockSynchronizeResponse[0].remoteAttendanceId ||
                list[0].status != RegistrationStatus.completed
              ) {
                return false;
              }
              return true;
            }
              
          )
        )
      )).called(1);
    });

    test('Debe registrar el estado únicamente de los checkins y checkouts que se han sincronizado (checkin, checkout, -, checkin, checkout)', () async {
      final todayRegistrations = [
        // Primer par: checkIn con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 1,
          status: .pending,
        ),
        // Primer par: checkOut con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 17, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 1,
          status: .pending,
        ),
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 9, 0),
              location: LatLng(lat: 12.4567, lon: -86.9012),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-234567-0002',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 2,
          status: .pending,
        ),
        // Segundo par: checkIn con attendanceLocalId = 3
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 7, 30),
              location: LatLng(lat: 12.7890, lon: -86.3456),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-345678-0003',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 3,
          status: .pending,
        ),
        // Segundo par: checkOut con attendanceLocalId = 3
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 16, 30),
              location: LatLng(lat: 12.7890, lon: -86.3456),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-345678-0003',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 3,
          status: .pending,
        )
      ];
      
      // arrange
      final mockSynchronizeResponse = [
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkIn,
        ),
        RegistrationResult(
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkOut,
        ),
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 2,
          status: .failure,
          type: .checkIn,
        ),
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 3,
          status: .success,
          type: .checkIn,
        ),
        RegistrationResult(
          localAttendanceId: 3,
          remoteAttendanceId: 3,
          status: .success,
          type: .checkOut,
        )
      ];
      
      when(mockRepository.synchronize(any))
          .thenAnswer((_) async => mockSynchronizeResponse);
      when(mockRepository.markAsSynchronized(any))
          .thenAnswer((_) async => {});
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => []);
      
      // act
      await synchronizeImpl.call(todayRegistrations, projects);
      
      // assert
      verify(mockRepository.synchronize(todayRegistrations)).called(1);
      verify(mockRepository.markAsSynchronized(argThat(
        predicate<List<PendingRegistration>>(
          (list){
            if(list.length != 4) {
              return false;
            }
            if(list.any((r) => r.localAttendanceId == 2)) {
              return false;
            }
            if(
              list[0].localAttendanceId != todayRegistrations[0].localAttendanceId ||
              list[0].registration.type != todayRegistrations[0].registration.type ||
              list[0].remoteAttendanceId != mockSynchronizeResponse[0].remoteAttendanceId ||
              list[0].status != .completed
            ) {
              return false;
            }
            if(
              list[1].localAttendanceId != todayRegistrations[1].localAttendanceId ||
              list[1].registration.type != todayRegistrations[1].registration.type ||
              list[1].remoteAttendanceId != mockSynchronizeResponse[1].remoteAttendanceId ||
              list[1].status != .completed
            ) {
              return false;
            }
            if(
              list[2].localAttendanceId != todayRegistrations[3].localAttendanceId ||
              list[2].registration.type != todayRegistrations[3].registration.type ||
              list[2].remoteAttendanceId != mockSynchronizeResponse[3].remoteAttendanceId ||
              list[2].status != .completed
            ) {
              return false;
            }
            if(
              list[3].localAttendanceId != todayRegistrations[4].localAttendanceId ||
              list[3].registration.type != todayRegistrations[4].registration.type ||
              list[3].remoteAttendanceId != mockSynchronizeResponse[4].remoteAttendanceId ||
              list[3].status != .completed
            ) {
              return false;
            }
            return true;
          }
            
        )
      ))).called(1);
      
    });

    test('Debe registrar el estado únicamente de los checkins y checkouts que se han sincronizado (checkin, checkout, checkin, checkin, -)', () async {
      final todayRegistrations = [
        // Primer par: checkIn con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 1,
          status: .pending,
        ),
        // Primer par: checkOut con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 17, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 1,
          status: .pending,
        ),
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 9, 0),
              location: LatLng(lat: 12.4567, lon: -86.9012),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-234567-0002',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 2,
          status: .pending,
        ),
        // Segundo par: checkIn con attendanceLocalId = 3
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 7, 30),
              location: LatLng(lat: 12.7890, lon: -86.3456),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-345678-0003',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 3,
          status: .pending
        ),
        // Segundo par: checkOut con attendanceLocalId = 3
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 16, 30),
              location: LatLng(lat: 12.7890, lon: -86.3456),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-345678-0003',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 3,
          status: .pending,
        )
      ];
      
      // arrange
      final mockSynchronizeResponse = [
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkOut
        ),
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 2,
          status: .success,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 3,
          status: .success,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: 3,
          remoteAttendanceId: 3,
          status: .failure,
          type: .checkOut
        )
      ];
      
      when(mockRepository.synchronize(any))
          .thenAnswer((_) async => mockSynchronizeResponse);
      when(mockRepository.markAsSynchronized(any))
          .thenAnswer((_) async => {});
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => []);
      
      // act
      await synchronizeImpl.call(todayRegistrations, projects);
      
      // assert
      verify(mockRepository.synchronize(todayRegistrations)).called(1);
      verify(mockRepository.markAsSynchronized(argThat(
        predicate<List<PendingRegistration>>(
          (list){
            if(list.length != 4) {
              return false;
            }
            if(
              list[0].localAttendanceId != todayRegistrations[0].localAttendanceId ||
              list[0].registration.type != todayRegistrations[0].registration.type ||
              list[0].remoteAttendanceId != mockSynchronizeResponse[0].remoteAttendanceId ||
              list[0].status != RegistrationStatus.completed
            ) {
              return false;
            }
            if(
              list[1].localAttendanceId != todayRegistrations[1].localAttendanceId ||
              list[1].registration.type != todayRegistrations[1].registration.type ||
              list[1].remoteAttendanceId != mockSynchronizeResponse[1].remoteAttendanceId ||
              list[1].status != RegistrationStatus.completed
            ) {
              return false;
            }
            if(
              list[2].localAttendanceId != todayRegistrations[2].localAttendanceId ||
              list[2].registration.type != todayRegistrations[2].registration.type ||
              list[2].remoteAttendanceId != mockSynchronizeResponse[2].remoteAttendanceId ||
              list[2].status != RegistrationStatus.completed
            ) {
              return false;
            }
            if(
              list[3].localAttendanceId != todayRegistrations[3].localAttendanceId ||
              list[3].registration.type != todayRegistrations[3].registration.type ||
              list[3].remoteAttendanceId != mockSynchronizeResponse[3].remoteAttendanceId ||
              list[3].status != RegistrationStatus.completed
            ) {
              return false;
            }
            return true;
          }
            
        )
      ))).called(1);
      
    });

    test('Debe registrar el estado únicamente de los checkins y checkouts que se han sincronizado (checkin, checkout, -, checkin, checkin, -)', () async {
      final todayRegistrations = [
        // Primer par: checkIn con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 1,
          status: .pending,
        ),
        // Primer par: checkOut con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 17, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 1,
          status: .pending,
        ),
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 9, 0),
              location: LatLng(lat: 12.4567, lon: -86.9012),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-234567-0002',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 2,
          status: .pending,
        ),
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 9, 0),
              location: LatLng(lat: 12.4567, lon: -86.9012),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-234567-0002',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 3,
          status: .pending,
        ),
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 7, 30),
              location: LatLng(lat: 12.7890, lon: -86.3456),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-345678-0003',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 4,
          status: .pending
        ),
        // Segundo par: checkOut con attendanceLocalId = 4
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 16, 30),
              location: LatLng(lat: 12.7890, lon: -86.3456),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-345678-0003',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 4,
          status: .pending,
        )
      ];
      
      // arrange
      final mockSynchronizeResponse = [
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkOut
        ),
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 2,
          status: .failure,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 3,
          status: .success,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: null,
          remoteAttendanceId: 4,
          status: .success,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: 4,
          remoteAttendanceId: 4,
          status: .failure,
          type: .checkOut
        )
      ];
      
      when(mockRepository.synchronize(any))
          .thenAnswer((_) async => mockSynchronizeResponse);
      when(mockRepository.markAsSynchronized(any))
          .thenAnswer((_) async => {});
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => []);
      
      // act
      await synchronizeImpl.call(todayRegistrations, projects);
      
      // assert
      verify(mockRepository.synchronize(todayRegistrations)).called(1);
      verify(mockRepository.markAsSynchronized(argThat(
        predicate<List<PendingRegistration>>(
          (list){
            if(list.length != 4) {
              return false;
            }
            if(
              list[0].localAttendanceId != todayRegistrations[0].localAttendanceId ||
              list[0].registration.type != todayRegistrations[0].registration.type ||
              list[0].remoteAttendanceId != mockSynchronizeResponse[0].remoteAttendanceId ||
              list[0].status != RegistrationStatus.completed
            ) {
              return false;
            }
            if(
              list[1].localAttendanceId != todayRegistrations[1].localAttendanceId ||
              list[1].registration.type != todayRegistrations[1].registration.type ||
              list[1].remoteAttendanceId != mockSynchronizeResponse[1].remoteAttendanceId ||
              list[1].status != RegistrationStatus.completed
            ) {
              return false;
            }
            if(
              list[2].localAttendanceId != todayRegistrations[3].localAttendanceId ||
              list[2].registration.type != todayRegistrations[3].registration.type ||
              list[2].remoteAttendanceId != mockSynchronizeResponse[3].remoteAttendanceId ||
              list[2].status != RegistrationStatus.completed
            ) {
              return false;
            }
            if(
              list[3].localAttendanceId != todayRegistrations[4].localAttendanceId ||
              list[3].registration.type != todayRegistrations[4].registration.type ||
              list[3].remoteAttendanceId != mockSynchronizeResponse[4].remoteAttendanceId ||
              list[3].status != RegistrationStatus.completed
            ) {
              return false;
            }
            return true;
          }
            
        )
      ))).called(1);
      
    });
  });

  test('Debe retornar los pending actualizados (aquellos que traen error)', () async {
      final todayRegistrations = [
        // Primer par: checkIn con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 1,
          status: .pending
        ),
        // Primer par: checkOut con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 17, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .pending
        )
      ];

      // arrange
      final mockSynchronizeResponse = [
        RegistrationResult(
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .failure,
          type: .checkOut
        )
      ];
      
      when(mockRepository.synchronize(any))
          .thenAnswer((_) async => mockSynchronizeResponse);
      when(mockRepository.markAsSynchronized(any))
          .thenAnswer((_) async => {});
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => [
            todayRegistrations[0].copyWith(
              status: .completed,
              remoteAttendanceId: mockSynchronizeResponse[0].remoteAttendanceId
            ),
            todayRegistrations[1]
          ]);
      
      // act
      final result = await synchronizeImpl.call(todayRegistrations, projects);
      
      // assert
      verify(mockRepository.synchronize([todayRegistrations[0], todayRegistrations[1]])).called(1);
            // Se verifica que se haya llamado a markAsSynchronized con las registrations actualizadas
      verify(mockRepository.markAsSynchronized(
        argThat(
          predicate<List<PendingRegistration>>(
            (list){
              if(
                list[0].localAttendanceId != todayRegistrations[0].localAttendanceId ||
                list[0].registration.type != todayRegistrations[0].registration.type ||
                list[0].remoteAttendanceId != mockSynchronizeResponse[0].remoteAttendanceId ||
                list[0].status != RegistrationStatus.completed
              ) {
                return false;
              }
              return true;
            }
              
          )
        )
      )).called(1);

      expect(result[0].localAttendanceId, todayRegistrations[0].localAttendanceId);
      expect(result[0].status, RegistrationStatus.completed);
      expect(result[1].localAttendanceId, todayRegistrations[1].localAttendanceId);
      expect(result[1].status, RegistrationStatus.canceled);
    });

    test('Debe eliminar los pending registrations con status repeated y debe retornar el estado actualizado de estos', () async {
      final todayRegistrations = [
        // Primer par: checkIn con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 1,
          status: .pending
        ),
        // Primer par: checkOut con attendanceLocalId = 1
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 17, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .pending
        ),
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0101',
              worker: null,
            ),
            type: .checkIn,
          ),
          localAttendanceId: 2,
          status: .pending
        ),
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0101',
              worker: null,
            ),
            type: .checkOut,
          ),
          localAttendanceId: 2,
          status: .pending
        )
      ];

      // arrange
      final mockSynchronizeResponse = [
        RegistrationResult(
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: 1,
          remoteAttendanceId: 1,
          status: .success,
          type: .checkOut
        ),
        RegistrationResult(
          localAttendanceId: 2,
          remoteAttendanceId: 2,
          status: .repeated,
          type: .checkIn
        ),
        RegistrationResult(
          localAttendanceId: 2,
          remoteAttendanceId: 2,
          status: .repeated,
          type: .checkOut
        )
      ];
      
      when(mockRepository.synchronize(any))
          .thenAnswer((_) async => mockSynchronizeResponse);
      when(mockRepository.markAsSynchronized(any))
          .thenAnswer((_) async => {});
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => [
            todayRegistrations[0].copyWith(
              status: .completed,
              remoteAttendanceId: mockSynchronizeResponse[0].remoteAttendanceId
            ),
            todayRegistrations[1].copyWith(
              status: .completed,
              remoteAttendanceId: mockSynchronizeResponse[1].remoteAttendanceId
            ),
            todayRegistrations[2],
            todayRegistrations[3]
          ]);
      
      // act
      final result = await synchronizeImpl.call(todayRegistrations, projects);
      
      // assert
      verify(mockRepository.synchronize([
        todayRegistrations[0],
        todayRegistrations[1],
        todayRegistrations[2],
        todayRegistrations[3]
      ])).called(1);
            // Se verifica que se haya llamado a markAsSynchronized con las registrations actualizadas
      verify(mockRepository.markAsSynchronized(
        argThat(
          predicate<List<PendingRegistration>>(
            (list){
              if(
                list[0].localAttendanceId != todayRegistrations[0].localAttendanceId ||
                list[0].registration.type != todayRegistrations[0].registration.type ||
                list[0].remoteAttendanceId != mockSynchronizeResponse[0].remoteAttendanceId ||
                list[0].status != RegistrationStatus.completed
              ) {
                return false;
              }
              if(
                list[1].localAttendanceId != todayRegistrations[1].localAttendanceId ||
                list[1].registration.type != todayRegistrations[1].registration.type ||
                list[1].remoteAttendanceId != mockSynchronizeResponse[1].remoteAttendanceId ||
                list[1].status != RegistrationStatus.completed
              ) {
                return false;
              }
              return true;
            }
              
          )
        )
      )).called(1);

      verify(mockRepository.removeRegistrations(
        argThat(
          predicate<List<int>>(
            (list){
              if(list.length != 1) {
                return false;
              }
              if(
                list[0] != todayRegistrations[2].localAttendanceId
              ) {
                return false;
              }
              return true;
            }
              
          )
        )
      ));

      expect(result.length, 4);
      expect(result[0].localAttendanceId, todayRegistrations[0].localAttendanceId);
      expect(result[0].status, RegistrationStatus.completed);
      expect(result[1].localAttendanceId, todayRegistrations[1].localAttendanceId);
      expect(result[1].status, RegistrationStatus.completed);
      expect(result[2].localAttendanceId, todayRegistrations[2].localAttendanceId);
      expect(result[2].status, RegistrationStatus.repeated);
      expect(result[3].localAttendanceId, todayRegistrations[3].localAttendanceId);
      expect(result[3].status, RegistrationStatus.repeated);
    });
}