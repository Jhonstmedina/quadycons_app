// ignore_for_file: strict_top_level_inference

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/register_type.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/data/services/geo_location.dart';
import 'package:quadycons/domain/exceptions.dart';
import 'package:quadycons/domain/logic/locations_comparer.dart';
import 'package:quadycons/domain/repositories/code_scan_repository.dart';

part 'code_scan_event.dart';
part 'code_scan_state.dart';

class CodeScanBloc extends Bloc<CodeScanEvent, CodeScanState> {

  final CodeScanRepository repository;
  final Geolocation geolocation;
  final LocationsComparer locationsComparer;

  CodeScanBloc({
    required this.repository,
    required this.geolocation,
    required this.locationsComparer
  }) : super(Registrating()) {
    _reviewGPS();
    on<InsertScanInfo>(_insertScanInfo);
    on<SetRegisterType>(_setRegisterType);
    on<RetryScanEnd>(_endScan);
    on<ResetBloc>(_resetBloc);
  }

  void _reviewGPS() {
    if(!geolocation.hasWarmFix()) {
      geolocation.startWarm();
    }
  }

  Future<void> _insertScanInfo(InsertScanInfo event, Emitter<CodeScanState> emit) async {
    _reviewGPS();
    IdCodeInfo? idCodeInfo = event.idCodeInfo;
    if(idCodeInfo != null) {
      idCodeInfo = idCodeInfo.copyWith(
        worker: idCodeInfo.worker!.copyWith(
          project: event.project
        )
      );
      late IdCodeInfo idInfo;
      try {
        idInfo = await repository.getInfoByIdBase(idCodeInfo, event.allProjects);
      } catch (e) {
        final message = e is GeneralException?
          e.message :
          'Ha ocurrido un error inesperado';
        emit((state as Registrating).copyWith(
          errorMessage: message,
          isLoading: false
        ));
        return;
      }
      var initState = state as Registrating;
      initState = initState.copyWith(
        idDocInfo: idInfo,
        isLoading: false
      );
      emit(initState);
      if(initState.registerType != null) {
        await _endScan(
          null,
          emit,
          initState: initState,
          project: event.project
        );
      }
    }
    
  }

  Future<void> _setRegisterType(SetRegisterType event, Emitter<CodeScanState> emit) async {
    _reviewGPS();
    var initState = state as Registrating;
    initState = initState.copyWith(
      registerType: event.registerType
    );
    emit(initState);
    if(initState.idDocInfo != null) {
      await _endScan(
        null,
        emit,
        initState: initState,
        project: event.project
      );
    }
  }

  Future<void> _endScan(event, Emitter<CodeScanState> emit, {Registrating? initState, Project? project}) async {
    if(initState != null) {
      emit(initState.copyWith(
        isLoading: true
      ));
    }
    initState ??= state as Registrating;
    if( geolocation.hasWarmFix() ) {
      try {
        final location = await geolocation.getCurrentPosition();
        //final location = await NativeLocation.getCurrentLocation();
        if(location != null) {
          if(event is RetryScanEnd) {
            project = event.project;
          }
          emit(initState.copyWith(
            isInFence: true,
            errorMessage: null,
            currentLocation: location,
            isLoading: false
          ));
        }
      } on GeneralException catch (e) {
        geolocation.startWarm();
        emit(initState.copyWith(
          isInFence: false,
          errorMessage: e.message,
          currentLocation: null,
          isLoading: false
        ));
      }
    } else {
      emit(initState.copyWith(
        errorMessage: 'Hubo un problema con el GPS. Vuélve a intentarlo en unos momentos.'
      ));
    }
  }

  void _resetBloc(ResetBloc event, Emitter<CodeScanState> emit) {
    emit(Registrating());
  }

  @mustCallSuper
  @override
  Future<void> close() async {
    geolocation.stopWarm();
    super.close();
  }
}
