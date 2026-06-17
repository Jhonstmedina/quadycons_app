import 'package:quadycons/data/db/dtos/summary_dto.dart';

abstract class SummaryLocalDataSource {
  Future<SummaryDTO> getSummary(int projectId);
}

class SummaryLocalDataSourceImpl implements SummaryLocalDataSource {
  @override
  Future<SummaryDTO> getSummary(int projectId) async {
    if(projectId == 1) {
      return SummaryDTO(inputs: 100, outputs: 80, pending: 20);
    } else if (projectId == 2) {
      return SummaryDTO(inputs: 50, outputs: 40, pending: 0);
    } else {
      return SummaryDTO(inputs: 120, outputs: 80, pending: 30);
    }
  }
}