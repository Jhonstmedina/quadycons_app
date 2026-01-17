import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
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
  }


  Future<void> _insertScanInfo(InsertScanInfo event, Emitter<CodeScanState> emit) async {
    final idCodeInfo = event.idCodeInfo;
    if(idCodeInfo != null) {
      final idInfo = await repository.getInfoByIdBase(idCodeInfo);
      var initState = state as Registrating;
      initState = initState.copyWith(
        idDocInfo: idInfo
      );
      emit(initState);
      if(initState.registerType != null) {
        await _endScan(null, emit, initState);
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
      await _endScan(null, emit, initState);
    }
  }

  Future<void> _endScan(_, Emitter<CodeScanState> emit, [Registrating? initState]) async {
    initState ??= state as Registrating;
    final location = await geolocation.getCurrentPosition();
    final fence = await repository.getFence();
    if(location != null) {
      final isInFence = locationsComparer.isInsideFence(
        location,
        fence
      );
      emit(initState.copyWith(
        isInFence: isInFence,
        errorMessage: isInFence ? null : "Fuera del área de registro",
        currentLocation: location
      ));
    }
  }
}
