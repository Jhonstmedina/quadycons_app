import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quadycons/data/platform/permissions_controller.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {

  final PermissionsController permissionsController;

  PermissionsBloc({
    required this.permissionsController
  }) : super(PermissionsPending()) {
    on<RequestPermissions>(_requestPermissions);
    on<_UpdatePermissionsStatus>(_updatePermissionsStatus);
    add(_UpdatePermissionsStatus());
  }


  Future<void> _updatePermissionsStatus(
    _UpdatePermissionsStatus event,
    Emitter<PermissionsState> emit
  ) async {
    final cameraGranted = await permissionsController.checkCameraPermission();
    final locationGranted = await permissionsController.checkLocationPermission();
    emit(PermissionsPending(
      cameraIsGranted: cameraGranted,
      locationIsGranted: locationGranted,
      isLoading: false
    ));
  }

  Future<void> _requestPermissions(
    _,
    Emitter<PermissionsState> emit
  ) async {
    final initState = state as PermissionsPending;
    final granted = await permissionsController.requestPermissions();
    if( granted ) {
      emit(initState.copyWith(
        cameraIsGranted: true,
        locationIsGranted: true,
        isLoading: false
      ));
    }
  }
}
