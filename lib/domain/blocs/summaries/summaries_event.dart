part of 'summaries_bloc.dart';

@immutable
sealed class SummariesEvent {}

final class LoadSummary extends SummariesEvent {
  final Project project;
  LoadSummary({required this.project});
}

final class RefreshSummary extends SummariesEvent {
  final Project project;
  RefreshSummary({required this.project});
}