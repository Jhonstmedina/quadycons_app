import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/domain/repositories/synchronization_repository.dart';
import 'package:quadycons/domain/use_cases/clean_last_registrations.dart';

@GenerateNiceMocks([MockSpec<SynchronizationRepository>()])
import 'clean_last_registrations_test.mocks.dart';

void main() {
  late CleanLastRegistrationsImpl cleanLastRegistrations;
  late MockSynchronizationRepository mockRepository;
  late List<Project> projects;

  setUp(() {
    mockRepository = MockSynchronizationRepository();
    cleanLastRegistrations = CleanLastRegistrationsImpl(repository: mockRepository);
    projects = [
      Project(id: 1, name: 'Proyecto 1', geoLocation: null, geoFence: null),
      Project(id: 2, name: 'Proyecto 2', geoLocation: null, geoFence: null)
    ];
  });

  group('CleanLastRegistrations', () {
    test('Debe eliminar el attendance de todos los registros', () async {
      // Arrange
      final registrations = [
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
          status: .completed
        )
      ];

      // Previous
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => []);

      // Act
      final result = await cleanLastRegistrations(registrations, projects);

      // Verify
      verify(mockRepository.removeRegistrations([1])).called(1);
      verify(mockRepository.getLastRegistrations(projects)).called(1);

      // Assert
      expect(result.length, 0);
      
    });
    test('Debe eliminar solo los attendances de aquellos registros que están completos', () async {
      // Arrange
      final registrations = [
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
          remoteAttendanceId: 1,
          status: .completed,
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
          status: .completed,
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
          status: .pending
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
          status: .pending
        )
      ];

      // Previous
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => [registrations[2], registrations[3]]);

      // Act
      final result = await cleanLastRegistrations(registrations, projects);

      // Verify
      verify(mockRepository.removeRegistrations([1])).called(1);
      verify(mockRepository.getLastRegistrations(projects)).called(1);

      // Assert
      expect(result.length, 2);
      expect(result[0].localAttendanceId, registrations[2].localAttendanceId);
      expect(result[0].registration.idCodeInfo.docNumber, registrations[2].registration.idCodeInfo.docNumber);
      expect(result[1].localAttendanceId, registrations[3].localAttendanceId);
      expect(result[1].registration.idCodeInfo.docNumber, registrations[3].registration.idCodeInfo.docNumber);
    });

    test('No debe eliminar solo los attendances de aquellos registros cuyo par no esté completo (checkin [*], checkout [x])', () async {
      // Arrange
      final registrations = [
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null
            ),
            type: .checkIn
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
          status: .completed,
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
              time: DateTime(2026, 1, 21, 7, 30),
              location: LatLng(lat: 12.7890, lon: -86.3456),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-345678-0003',
              worker: null,
            ),
            type: .checkIn,
          ),
          remoteAttendanceId: 1001,
          localAttendanceId: 4,
          status: .completed
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

      // Previous
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => [registrations[2], registrations[3], registrations[4]]);

      // Act
      final result = await cleanLastRegistrations(registrations, projects);

      // Verify
      verify(mockRepository.removeRegistrations([1])).called(1);
      verify(mockRepository.getLastRegistrations(projects)).called(1);

      // Assert
      expect(result.length, 3);
      expect(result[0].localAttendanceId, registrations[2].localAttendanceId);
      expect(result[0].registration.idCodeInfo.docNumber, registrations[2].registration.idCodeInfo.docNumber);
      expect(result[1].localAttendanceId, registrations[3].localAttendanceId);
      expect(result[1].registration.idCodeInfo.docNumber, registrations[3].registration.idCodeInfo.docNumber);
      expect(result[2].localAttendanceId, registrations[4].localAttendanceId);
      expect(result[2].registration.idCodeInfo.docNumber, registrations[4].registration.idCodeInfo.docNumber);
    });

    test('No debe eliminar aquellos registros que sean checkin y no tengan par', () async {
      // Arrange
      final registrations = [
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null
            ),
            type: .checkIn
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
          status: .completed,
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
          status: .completed,
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
          remoteAttendanceId: 1001,
          localAttendanceId: 4,
          status: .completed
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

      // Previous
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => [registrations[2], registrations[3], registrations[4]]);

      // Act
      final result = await cleanLastRegistrations(registrations, projects);

      // Verify
      verify(mockRepository.removeRegistrations([1])).called(1);
      verify(mockRepository.getLastRegistrations(projects)).called(1);

      // Assert
      expect(result.length, 3);
      expect(result[0].localAttendanceId, registrations[2].localAttendanceId);
      expect(result[0].registration.idCodeInfo.docNumber, registrations[2].registration.idCodeInfo.docNumber);
      expect(result[1].localAttendanceId, registrations[3].localAttendanceId);
      expect(result[1].registration.idCodeInfo.docNumber, registrations[3].registration.idCodeInfo.docNumber);
      expect(result[2].localAttendanceId, registrations[4].localAttendanceId);
      expect(result[2].registration.idCodeInfo.docNumber, registrations[4].registration.idCodeInfo.docNumber);
    });

    test('Debe eliminar los attendances de todos los registros que estén completos en pareja (checkin, checkout)', () async {
      // Arrange
      final registrations = [
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null
            ),
            type: .checkIn
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
          status: .completed,
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
          status: .completed,
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
          remoteAttendanceId: 1001,
          localAttendanceId: 4,
          status: .completed
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
        ),
        PendingRegistration(
          registration: Registration(
            check: Check(
              time: DateTime(2026, 1, 21, 8, 0),
              location: LatLng(lat: 12.1234, lon: -86.5678),
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: '001-123456-0001',
              worker: null
            ),
            type: .checkIn
          ),
          localAttendanceId: 5,
          status: .completed
        ),
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
          localAttendanceId: 5,
          status: .completed,
        ),
      ];

      // Previous
      when(mockRepository.getLastRegistrations(any))
          .thenAnswer((_) async => [registrations[2], registrations[3], registrations[4]]);

      // Act
      final result = await cleanLastRegistrations(registrations, projects);

      // Verify
      verify(mockRepository.removeRegistrations([1, 5])).called(1);
      verify(mockRepository.getLastRegistrations(projects)).called(1);

      // Assert
      expect(result.length, 3);
      expect(result[0].localAttendanceId, registrations[2].localAttendanceId);
      expect(result[0].registration.idCodeInfo.docNumber, registrations[2].registration.idCodeInfo.docNumber);
      expect(result[1].localAttendanceId, registrations[3].localAttendanceId);
      expect(result[1].registration.idCodeInfo.docNumber, registrations[3].registration.idCodeInfo.docNumber);
      expect(result[2].localAttendanceId, registrations[4].localAttendanceId);
      expect(result[2].registration.idCodeInfo.docNumber, registrations[4].registration.idCodeInfo.docNumber);
    });
  });
}
