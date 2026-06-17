part of 'projects_bloc.dart';

@immutable
sealed class ProjectsEvent {}

class LoadProjects extends ProjectsEvent {}

class ChooseProject extends ProjectsEvent {
  final Project? project;

  ChooseProject({required this.project});
}