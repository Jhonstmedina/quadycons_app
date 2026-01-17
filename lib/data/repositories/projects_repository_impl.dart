import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/data/local_data_source/auth_local_data_source.dart';
import 'package:quadycons/data/services/projects_service.dart';
import 'package:quadycons/domain/repositories/projects_repository.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsService projectsService;
  final AuthLocalDataSource localDataSource;

  ProjectsRepositoryImpl({
    required this.projectsService,
    required this.localDataSource,
  });

  @override
  Future<List<Project>> getProjects() async {
    final accessToken = await localDataSource.getAccessToken();
    return await projectsService.getProjects(accessToken!);
  }
}
