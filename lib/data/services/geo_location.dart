import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/exceptions.dart';

abstract class Geolocation {
  Future<LatLng?> getCurrentPosition();
}

class GeoLocationImpl implements Geolocation {
  @override
  Future<LatLng?> getCurrentPosition() async {
    try {
      final permissionGranted = await _verifyPermissions();
      if (!permissionGranted) return null;

      if (!await Geolocator.isLocationServiceEnabled()) return null;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      ).timeout(
        const Duration(seconds: 8),
        onTimeout: () => throw TimeoutException('GPS timeout'),
      );

      return LatLng(
        lat: position.latitude,
        lon: position.longitude,
      );
    } on TimeoutException {
      throw GeneralException(
        message: 'No pudimos obtener tu ubicación. Asegúrate de tener la ubicación activada y vuelve a intentarlo.'
      );
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