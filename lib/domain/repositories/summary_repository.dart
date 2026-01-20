import 'package:quadycons/data/db/dtos/summary_dto.dart';

abstract class SummaryRepository {
  Future<SummaryDTO> getSummary(int projectId);
}