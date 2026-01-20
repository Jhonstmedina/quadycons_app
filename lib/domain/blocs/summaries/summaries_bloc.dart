import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/data/db/dtos/summary_dto.dart';
import 'package:quadycons/domain/repositories/summary_repository.dart';

part 'summaries_event.dart';
part 'summaries_state.dart';

class SummariesBloc extends Bloc<SummariesEvent, SummariesState> {
  final SummaryRepository summaryRepository;
  
  SummariesBloc(this.summaryRepository) : super(SummariesInitial()) {
    on<LoadSummary>(_loadSummary);
  }
  
  Future<void> _loadSummary(LoadSummary event, Emitter<SummariesState> emit) async {
    final initState = state;
    if(initState is SummaryLoaded) {
      emit(initState.copyWith(isLoading: true));
    }
    final project = event.project;
    final summary = await summaryRepository.getSummary(project.id);
    emit(SummaryLoaded(
      summary: summary,
      project: project,
      isLoading: false
    ));
  }
}
