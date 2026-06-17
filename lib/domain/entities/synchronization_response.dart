import 'package:quadycons/domain/entities/registration_result.dart';

class SynchronizationResponse {
  final int successCount;
  final int failureCount;
  final List<RegistrationResult> results;
  SynchronizationResponse({
    required this.successCount,
    required this.failureCount,
    required this.results
  });
}