import 'package:quadycons/data/db/daos/project_dao.dart';
import 'package:quadycons/data/db/mappers/project_mapper.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/data/services/projects_service.dart';
import 'package:quadycons/domain/exceptions.dart';
import 'package:quadycons/domain/repositories/projects_repository.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsService projectsService;
  final ProjectsDao dao;
  final AccessTokenGetter localDataSource;
  final ConnectivityService connectivityService;

  ProjectsRepositoryImpl({
    required this.projectsService,
    required this.localDataSource,
    required this.dao,
    required this.connectivityService
  });

  @override
  Future<List<Project>> getProjects() async {
    late List<Project> projects;
    if( await connectivityService.thereIsConnectivity() ) {
      final accessToken = await localDataSource.getAccessToken();
      projects = await projectsService.getProjects(accessToken);
      final data = projects.map(ProjectMapper.toDb).toList();
      await dao.insertProjects(data);
    } else {
      final data = await dao.getAll();
      projects = data.map(ProjectMapper.fromDb).toList();
      if(projects.isEmpty) {
        throw GeneralException(message: 'No hay proyectos disponibles sin conexión');
      }
    }
    return projects;
  }
}
