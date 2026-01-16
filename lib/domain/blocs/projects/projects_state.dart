part of 'projects_bloc.dart';

@immutable
sealed class ProjectsState {}

final class ProjectsInitial extends ProjectsState {}

final class ProjectsLoaded extends ProjectsState {
  final List<Project> projects;
  final Project? chosenProject;

  ProjectsLoaded({
    required this.projects,
    this.chosenProject,
  });

  ProjectsLoaded copyWith({
    List<Project>? projects,
    Project? chosenProject,
  }) => ProjectsLoaded(
    projects: projects ?? this.projects,
    chosenProject: chosenProject ?? this.chosenProject,
  );
}
