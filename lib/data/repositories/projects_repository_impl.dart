import 'package:quadycons/data/db/daos/project_dao.dart';
import 'package:quadycons/data/db/mappers/project_mapper.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/data/local_data_source/auth_local_data_source.dart';
import 'package:quadycons/data/services/projects_service.dart';
import 'package:quadycons/domain/repositories/projects_repository.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsService projectsService;
  final ProjectsDao dao;
  final AuthLocalDataSource localDataSource;

  ProjectsRepositoryImpl({
    required this.projectsService,
    required this.localDataSource,
    required this.dao
  });

  @override
  Future<List<Project>> getProjects() async {
    final accessToken = await localDataSource.getAccessToken();
    final projects = await projectsService.getProjects(accessToken);
    final data = projects.map(ProjectMapper.toDb).toList();
    await dao.insertProjects(data);
    return projects;
  }
}
