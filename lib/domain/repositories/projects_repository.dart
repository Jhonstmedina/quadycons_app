import 'package:quadycons/data/entities/project.dart';

abstract class ProjectsRepository {
  Future<List<Project>> getProjects();
}
