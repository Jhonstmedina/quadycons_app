import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadycons/core/app_dimens.dart';
import 'package:quadycons/domain/blocs/projects/projects_bloc.dart';
import 'package:quadycons/domain/blocs/summaries/summaries_bloc.dart';
import 'package:quadycons/ui/widgets/box.dart';
import 'package:quadycons/ui/widgets/custom_app_bar.dart';
import 'package:quadycons/ui/widgets/projects_select.dart';
import 'package:quadycons/ui/widgets/summary_box.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: BlocListener<ProjectsBloc, ProjectsState>(
            listener: (context, projectsState) {
              if (projectsState is ProjectsLoaded &&
                  projectsState.chosenProject != null) {
                context.read<SummariesBloc>().add(
                  LoadSummary(project: projectsState.chosenProject!),
                );
              }
            },
            child: BlocBuilder<SummariesBloc, SummariesState>(
              builder: (context, state) {
                if (state is! SummaryLoaded) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Box(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Resumen de hoy',
                              style: AppDimens.titleLargeStyle(context)
                            )
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: SummaryBox(
                                  label: 'Ingresos',
                                  value: '${state.summary.inputs}',
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: SummaryBox(
                                  label: 'Salidas',
                                  value: '${state.summary.outputs}',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: SummaryBox(
                                  label: 'Pendientes',
                                  value: '${state.summary.pending}',
                                ),
                              ),
                              SizedBox(width: 15),
                              BlocBuilder<ProjectsBloc, ProjectsState>(
                                builder: (context, projectsState) {
                                  projectsState =
                                      projectsState as ProjectsLoaded;
                                  return Expanded(
                                    child: SummaryBox(
                                      label: 'Proyecto',
                                      value:
                                          projectsState.chosenProject?.name ??
                                          'No seleccionado',
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    ProjectsSelect(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
