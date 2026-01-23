import 'package:quadycons/domain/entities/lat_lng.dart';

class Project {
  final int id;
  final String name;
  final LatLng? geoLocation;
  final double? geoFence;

  Project({
    required this.id,
    required this.name,
    required this.geoLocation,
    required this.geoFence,
  });
}
