import 'package:quadycons/data/entities/summary.dart';
import 'package:quadycons/data/local_data_source/summary_local_data_source.dart';
import 'package:quadycons/domain/repositories/summary_repository.dart';

class SummaryRepositoryImpl implements SummaryRepository {
  final SummaryLocalDataSource localDataSource;

  SummaryRepositoryImpl({required this.localDataSource});

  @override
  Future<Summary> getSummary(int projectId) async {
    return await localDataSource.getSummary(projectId);
  }
}