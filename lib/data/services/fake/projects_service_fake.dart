import 'package:quadycons/data/services/geo_location.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/data/services/projects_service.dart';

class ProjectsServiceFake implements ProjectsService {

  final Geolocation geoLocation;

  ProjectsServiceFake({required this.geoLocation});

  @override
  Future<List<Project>> getProjects(String accessToken) async {
    await Future.delayed(Duration(seconds: 1));
    final currentLocation = await geoLocation.getCurrentPosition();
    return [
      Project(
        id: 1,
        name: 'Fake Project 1',
        geoLocation: LatLng(
          lat: currentLocation!.lat + 0.00001,
          lon: currentLocation.lon + 0.00001
        ),
        geoFence: 100.0
      ),
      Project(
        id: 2,
        name: 'Fake Project 2',
        geoLocation: LatLng(
          lat: currentLocation.lat + 0.1,
          lon: currentLocation.lon + 0.1
        ),
        geoFence: 110.0
      ),
      Project(
        id: 3,
        name: 'Fake Project 3',
        geoLocation: LatLng(
          lat: currentLocation.lat + 3,
          lon: currentLocation.lon + 3
        ),
        geoFence: 85.0
      )
    ];
  }
} 