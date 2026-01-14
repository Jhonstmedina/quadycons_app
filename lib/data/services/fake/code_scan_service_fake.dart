import 'package:quadycons/data/entities/id_code_info.dart';
import 'package:quadycons/data/entities/lat_lng.dart';
import 'package:quadycons/data/services/code_scan_service.dart';
import 'package:quadycons/data/services/geo_location.dart';

class CodeScanServiceFake implements CodeScanService {
  
  final Geolocation geoLocation;

  CodeScanServiceFake({required this.geoLocation});
  
  @override
  Future<Worker> getInfoByIdentification(String code, _) async {
    // Simula una respuesta falsa para pruebas
    await Future.delayed(Duration(seconds: 1)); // Simula tiempo de espera
    return Worker(
      id: code,
      name: 'Juan Pérez',
      profileUrl: 'https://www.diamondartclub.com/cdn/shop/files/aragorn-diamond-art-painting-46043931672769.jpg?v=1762461207&width=3000',
      position: 'Developer'
    );
  }

  @override
  Future<LatLng> getFence(String accessToken) async {
    final position = await geoLocation.getCurrentPosition();
    if(position != null) {
      return LatLng(lat: position.lat + 0.00001, lon: position.lon + 0.00001);
    } else {
      return LatLng(lat: 0.0, lon: 0.0);
    }
  }
}