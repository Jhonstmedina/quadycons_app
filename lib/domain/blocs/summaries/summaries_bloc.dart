import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/data/db/dtos/summary_dto.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/domain/repositories/summary_repository.dart';
import 'package:quadycons/data/db/daos/attendance_dao.dart';

part 'summaries_event.dart';
part 'summaries_state.dart';

class SummariesBloc extends Bloc<SummariesEvent, SummariesState> {
  final SummaryRepository summaryRepository;
  final ConnectivityService connectivityService;
  final AttendanceDao attendanceDao;

  SummariesBloc(
    this.summaryRepository,
    this.connectivityService,
    this.attendanceDao,
  ) : super(SummariesInitial()) {
    on<LoadSummary>(_loadSummary);
    on<RefreshSummary>(_refreshSummary);
  }

  Future<void> _loadSummary(LoadSummary event, Emitter<SummariesState> emit) async {
    final initState = state;

    if (initState is SummaryLoaded) {
      emit(initState.copyWith(isLoading: true));
    }
    final summary = await summaryRepository.getSummary(event.project.id);
    emit(SummaryLoaded(
      summary: summary,
      project: event.project,
      isLoading: false,
    ));
  }

  Future<void> _refreshSummary(RefreshSummary event, Emitter<SummariesState> emit) async {
    final initState = state;
    if (initState is SummaryLoaded) {
      emit(initState.copyWith(isLoading: true, message: null));
    }

    // Verificar conexión
    if (!await connectivityService.thereIsConnectivity()) {
      if (initState is SummaryLoaded) {
        emit(initState.copyWith(
          isLoading: false,
          message: 'Sin conexión. Prueba actualizar cuando tengas internet.',
        ));
      }
      return;
    }

    // Verificar si hay registros pendientes de sincronizar
    final hasPending = await attendanceDao.hasPendingSyncToday();
    if (hasPending) {
      if (initState is SummaryLoaded) {
        emit(initState.copyWith(
          isLoading: false,
          message: 'Tienes registros pendientes de sincronizar. Ve a Sincronización primero.',
          hasPendingSync: true,
        ));
      }
      return;
    }

    // Traer y guardar en cache
    try {
      final summary = await summaryRepository.getRemoteSummary(event.project.id);
      emit(SummaryLoaded(
        summary: summary,
        project: event.project,
        isLoading: false,
        message: 'Resumen actualizado',
      ));
    } catch (e) {
      if (initState is SummaryLoaded) {
        emit(initState.copyWith(
          isLoading: false,
          message: 'Error al actualizar: $e',
        ));
      }
    }
  }
}