import 'package:quadycons/data/entities/summary.dart';

abstract class SummaryRepository {
  Future<Summary> getSummary(int projectId);
}