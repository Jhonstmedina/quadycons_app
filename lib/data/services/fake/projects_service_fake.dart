import 'package:quadycons/data/entities/lat_lng.dart';
import 'package:quadycons/data/entities/project.dart';
import 'package:quadycons/data/services/projects_service.dart';

class ProjectsServiceFake implements ProjectsService {
  
  @override
  Future<List<Project>> getProjects(String accessToken) async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Project(
        id: 1,
        name: 'Fake Project 1',
        geoLocation: LatLng(lat: 1, lon: 1),
        geoFence: 100.0
      ),
      Project(
        id: 2,
        name: 'Fake Project 2',
        geoLocation: LatLng(lat: 2, lon: 2),
        geoFence: 110.0
      ),
      Project(
        id: 3,
        name: 'Fake Project 3',
        geoLocation: LatLng(lat: 3, lon: 3),
        geoFence: 85.0
      )
    ];
  }
} 