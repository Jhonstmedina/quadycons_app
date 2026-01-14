import 'package:permission_handler/permission_handler.dart';

class PermissionsController {
  Future<bool> requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.locationWhenInUse,
    ].request();

    final cameraGranted = statuses[Permission.camera]?.isGranted ?? false;
    final locationGranted =
        statuses[Permission.locationWhenInUse]?.isGranted ?? false;

    return cameraGranted && locationGranted;
  }
}