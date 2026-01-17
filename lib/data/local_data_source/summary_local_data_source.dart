import 'package:quadycons/data/entities/summary.dart';

abstract class SummaryLocalDataSource {
  Future<Summary> getSummary(int projectId);
}

class SummaryLocalDataSourceImpl implements SummaryLocalDataSource {
  @override
  Future<Summary> getSummary(int projectId) async {
    if(projectId == 1) {
      return Summary(inputs: 100, outputs: 80, pending: 20);
    } else if (projectId == 2) {
      return Summary(inputs: 50, outputs: 40, pending: 0);
    } else {
      return Summary(inputs: 120, outputs: 80, pending: 30);
    }
  }
}