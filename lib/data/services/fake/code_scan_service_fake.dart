import 'dart:math';

import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/data/services/code_scan_service.dart';
import 'package:quadycons/data/services/geo_location.dart';
import 'package:quadycons/domain/entities/project.dart';

class CodeScanServiceFake implements CodeScanService {
  
  final Geolocation geoLocation;

  CodeScanServiceFake({required this.geoLocation});
  
  @override
  Future<Worker> getInfoByIdentification(String code, _) async {
    // Simula una respuesta falsa para pruebas
    await Future.delayed(Duration(seconds: 1)); // Simula tiempo de espera
    return Worker(
      id: Random().nextInt(999999),
      name: 'John Wick',
      profileUrl: 'https://www.diamondartclub.com/cdn/shop/files/aragorn-diamond-art-painting-46043931672769.jpg?v=1762461207&width=3000',
      position: 'Developer',
      project: Project(
        id: 1,
        name: 'Project X',
        geoLocation: LatLng(lat: 40.7128, lon: -74.0060),
        geoFence: 100
      )
    );
  }
}