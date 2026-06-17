import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/exceptions.dart';

abstract class Geolocation {
  Future<void> startWarm();
  Future<void> stopWarm();
  bool hasWarmFix({Duration maxAge = const Duration(seconds: 15)});
  Future<LatLng?> getCurrentPosition();
}

class GeoLocationImpl implements Geolocation {

  StreamSubscription<Position>? _subscription;
  Position? _lastPosition;

  Position? get warmPosition => _lastPosition;

  bool get isWarming => _subscription != null;

  Future<void> startWarm() async {
    if (_subscription != null) return;

    _subscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // fuerza GPS real
        distanceFilter: 0,
      ),
    ).listen((position) {
      _lastPosition = position;
    });
  }

  Future<void> stopWarm() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  bool hasWarmFix({Duration maxAge = const Duration(seconds: 60)}) {
    if (_lastPosition == null) return false;
    final timestamp = _lastPosition!.timestamp;
    return DateTime.now().difference(timestamp) <= maxAge;
  }

  @override
  Future<LatLng?> getCurrentPosition() async {
    try {
      final permissionGranted = await _verifyPermissions();
      if (!permissionGranted) return null;

      if (!await Geolocator.isLocationServiceEnabled()) return null;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      ).timeout(
        const Duration(seconds: 15),
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