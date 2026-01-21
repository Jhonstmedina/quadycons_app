import 'package:quadycons/domain/entities/registration.dart';

abstract class SynchronizeRepository {
  Future<List<Registration>> getPendingRegistrations();
  Future<void> synchronize();
}