import 'dart:math';
import 'package:quadycons/domain/entities/lat_lng.dart';

class LocationsComparer {
  static double radiusMeters = 50.0;

  bool isInsideFence(LatLng location, LatLng center) =>
    distanceTo(center, location) < radiusMeters;

  /// Calcula la distancia en metros entre dos puntos usando la fórmula de Haversine
  /// Retorna la distancia en metros
  double distanceTo(LatLng center, LatLng other) {
    const double earthRadiusMeters = 6371000; // Radio de la Tierra en metros
    
    // Convertir grados a radianes
    double lat1Rad = _toRadians(center.lat);
    double lat2Rad = _toRadians(other.lat);
    double deltaLatRad = _toRadians(other.lat - center.lat);
    double deltaLonRad = _toRadians(other.lon - center.lon);

    // Fórmula de Haversine
    double a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
               cos(lat1Rad) * cos(lat2Rad) *
               sin(deltaLonRad / 2) * sin(deltaLonRad / 2);
    
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadiusMeters * c;
  }

  /// Convierte grados a radianes
  double _toRadians(double degrees) {
    return degrees * pi / 180;
  }
}