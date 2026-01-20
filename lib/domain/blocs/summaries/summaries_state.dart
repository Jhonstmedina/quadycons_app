part of 'summaries_bloc.dart';

@immutable
sealed class SummariesState {}

final class SummariesInitial extends SummariesState {}

final class SummaryLoaded extends SummariesState {
  final SummaryDTO summary;
  final Project project;
  final bool isLoading;
  
  SummaryLoaded({
    required this.summary,
    required this.project,
    required this.isLoading
  });

  SummaryLoaded copyWith({
    SummaryDTO? summary,
    Project? project,
    bool? isLoading
  }) => SummaryLoaded(
    summary: summary ?? this.summary,
    project: project ?? this.project,
    isLoading: isLoading ?? this.isLoading
  );
}
