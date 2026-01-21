import 'package:quadycons/domain/entities/pending_registration.dart';

abstract class SynchronizeRepository {
  Future<List<PendingRegistration>> getPendingRegistrations();
  Future<void> synchronize();
}