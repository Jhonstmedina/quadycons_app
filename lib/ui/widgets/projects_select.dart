import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/blocs/projects/projects_bloc.dart';

class ProjectsSelect extends StatelessWidget {
  const ProjectsSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        if(state is! ProjectsLoaded) {
          return Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                'Cargando Proyectos...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                )
              ),
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Proyecto Delegado',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF5F3FF),
                borderRadius: BorderRadius.circular(20)
              ),
              child: DropdownButton<Project>(
                padding: EdgeInsets.zero,
                value: state.chosenProject,
                hint: Text(
                  'Seleccionar proyecto',
                  style: TextStyle(fontSize: 13)
                ),
                underline: SizedBox(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13
                ),
                alignment: AlignmentDirectional.centerStart,
                dropdownColor: Color(0xFFF5F3FF),
                borderRadius: BorderRadius.circular(20),
                menuMaxHeight: 300,
                items: state.projects.map((project) {
                  return DropdownMenuItem<Project>(
                    value: project,
                    child: Text(project.name),
                  );
                }).toList(),
                onChanged: (Project? selectedProject) {
                  if (selectedProject != null) {
                    context.read<ProjectsBloc>().add(
                      ChooseProject(project: selectedProject)
                    );
                  }
                }
              )
            )
          ]
        );
      }
    );
  }
}
