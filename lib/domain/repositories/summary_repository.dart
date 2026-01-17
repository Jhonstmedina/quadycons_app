import 'package:quadycons/domain/entities/summary.dart';

abstract class SummaryRepository {
  Future<Summary> getSummary(int projectId);
}