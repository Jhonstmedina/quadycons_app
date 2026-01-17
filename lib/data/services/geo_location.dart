import 'package:geolocator/geolocator.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';

abstract class Geolocation {
  Future<LatLng?> getCurrentPosition();
}

class GeoLocationImpl implements Geolocation {
  @override
  Future<LatLng?> getCurrentPosition() async {
    if (await _verifyPermissions()) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      return LatLng(
        lat: position.latitude,
        lon: position.longitude
      );
    }
    return null;
  }

  Future<bool> _verifyPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}