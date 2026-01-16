import 'package:flutter/material.dart';
import 'package:quadycons/data/entities/lat_lng.dart';

class Check {
  final TimeOfDay time;
  final LatLng location;
  Check({
    required this.time,
    required this.location
  });
}