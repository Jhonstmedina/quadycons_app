import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadycons/core/app_dimens.dart';
import 'package:quadycons/domain/blocs/projects/projects_bloc.dart';
import 'package:quadycons/domain/blocs/summaries/summaries_bloc.dart';
import 'package:quadycons/ui/utils/snack_manager.dart';
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
            child: BlocConsumer<SummariesBloc, SummariesState>(
              listener: (context, state) {
                if (state is SummaryLoaded && state.message != null) {
                  final isError = state.message!.contains('Sin conexión') || 
                                  state.message!.contains('Error');
                  SnackManager.showSnackBar(
                    context,
                    state.message!,
                    backgroundColor: isError ? Colors.amber : Colors.green,
                    textColor: isError ? Colors.black : Colors.white,
                    icon: isError ? Icons.wifi_off : Icons.check_circle,
                  );
                }
              },
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
                              style: AppDimens.titleLargeStyle(context),
                            ),
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
                              Expanded(
                                child: SummaryBox(
                                  label: 'Ausentes',
                                  value: '${state.summary.absent}',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          BlocBuilder<ProjectsBloc, ProjectsState>(
                            builder: (context, projectsState) {
                              projectsState = projectsState as ProjectsLoaded;
                              return SummaryBox(
                                label: 'Proyecto',
                                value: projectsState.chosenProject?.name ?? '',
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          // Botón Actualizar Resumen
                          ElevatedButton(
                            onPressed: state.isLoading
                                ? null
                                : () {
                                    final projectsState = context.read<ProjectsBloc>().state;
                                    if (projectsState is ProjectsLoaded &&
                                        projectsState.chosenProject != null) {
                                      context.read<SummariesBloc>().add(
                                        RefreshSummary(project: projectsState.chosenProject!),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2196F3),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: Size(double.infinity, 0),
                            ),
                            child: state.isLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.refresh, size: 20),
                                      SizedBox(width: 8),
                                      Text('Actualizar Resumen'),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    ProjectsSelect(),
                    SizedBox(height: 16),
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