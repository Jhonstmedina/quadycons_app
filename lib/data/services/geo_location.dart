import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';

abstract class Geolocation {
  Future<LatLng?> getCurrentPosition();
}

class GeoLocationImpl implements Geolocation {
  @override
  Future<LatLng?> getCurrentPosition() async {
    try {
      final permissionGranted = await _verifyPermissions();
      if (!permissionGranted) return null;

      final gpsEnabled = await Geolocator.isLocationServiceEnabled();
      if (!gpsEnabled) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: 0,
        ),
      );

      return LatLng(
        lat: position.latitude,
        lon: position.longitude,
      );
    } on LocationServiceDisabledException {
      return null;
    } on TimeoutException {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> _verifyPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
           permission == LocationPermission.whileInUse;
  }
}