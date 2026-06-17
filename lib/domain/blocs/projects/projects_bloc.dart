import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/repositories/projects_repository.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final ProjectsRepository repository;

  ProjectsBloc({
    required this.repository,
  }) : super(ProjectsInitial()) {
    on<LoadProjects>(_loadProjects);
    on<ChooseProject>(_chooseProject);
  }

  Future<void> _loadProjects(LoadProjects event, Emitter<ProjectsState> emit) async {
    try {
      final projects = await repository.getProjects();
      emit(ProjectsLoaded(
        projects: projects,
        chosenProject: projects.isNotEmpty ? projects[0] : null
      ));
    } catch (e) {
      // Manejar error si es necesario
      emit(ProjectsInitial());
    }
  }

  void _chooseProject(ChooseProject event, Emitter<ProjectsState> emit) {
    final project = event.project;
    if (state is ProjectsLoaded && event.project != null) {
      final currentState = state as ProjectsLoaded;
      emit(currentState.copyWith(chosenProject: project));
    }
  }
}
