// ignore_for_file: strict_top_level_inference

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/register_type.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/data/services/geo_location.dart';
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
    on<InsertScanInfo>(_insertScanInfo);
    on<SetRegisterType>(_setRegisterType);
    on<RetryScanEnd>(_endScan);
    on<ResetBloc>(_resetBloc);
  }


  Future<void> _insertScanInfo(InsertScanInfo event, Emitter<CodeScanState> emit) async {
    IdCodeInfo? idCodeInfo = event.idCodeInfo;
    if(idCodeInfo != null) {
      idCodeInfo = idCodeInfo.copyWith(
        worker: idCodeInfo.worker!.copyWith(
          projectId: event.project
        )
      );
      final idInfo = await repository.getInfoByIdBase(idCodeInfo, event.project);
      var initState = state as Registrating;
      initState = initState.copyWith(
        idDocInfo: idInfo
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
    initState ??= state as Registrating;
    final location = await geolocation.getCurrentPosition();
    if(location != null) {
      if(event is RetryScanEnd) {
        project = event.project;
      }
      final projectGeoLocation = project!.geoLocation;
      late bool isInFence;
      if(projectGeoLocation == null) {
        isInFence = true;
      } else {
        isInFence = locationsComparer.isInsideFence(
          location,
          LatLng(
            lat: projectGeoLocation.lat,
            lon: projectGeoLocation.lon
          ),
          project.geoFence!
        );
      }
      emit(initState.copyWith(
        isInFence: isInFence,
        errorMessage: isInFence ? null : "Fuera del área de registro",
        currentLocation: location
      ));
    }
  }

  void _resetBloc(ResetBloc event, Emitter<CodeScanState> emit) {
    emit(Registrating());
  }
}
