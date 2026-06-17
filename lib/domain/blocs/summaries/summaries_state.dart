part of 'summaries_bloc.dart';

@immutable
sealed class SummariesState {}

final class SummariesInitial extends SummariesState {}

final class SummaryLoaded extends SummariesState {
  final SummaryDTO summary;
  final Project project;
  final bool isLoading;
  final String? message;
  final bool hasPendingSync;

  SummaryLoaded({
    required this.summary,
    required this.project,
    required this.isLoading,
    this.message,
    this.hasPendingSync = false,
  });

  SummaryLoaded copyWith({
    SummaryDTO? summary,
    Project? project,
    bool? isLoading,
    String? message,
    bool? hasPendingSync,
  }) => SummaryLoaded(
    summary: summary ?? this.summary,
    project: project ?? this.project,
    isLoading: isLoading ?? this.isLoading,
    message: message,
    hasPendingSync: hasPendingSync ?? this.hasPendingSync,
  );
}