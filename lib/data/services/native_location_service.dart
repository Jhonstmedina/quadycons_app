import 'package:flutter/services.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';

class NativeLocation {
  static const _channel = MethodChannel('native_location');

  static Future<LatLng?> getCurrentLocation() async {
    try {
      final result =
          await _channel.invokeMethod<Map>('getCurrentLocation');

      if (result == null) return null;

      return LatLng(
        lat: result['lat'],
        lon: result['lon'],
      );
    } on PlatformException {
      return null;
    }
  }
}
