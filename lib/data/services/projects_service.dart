import 'package:dio/dio.dart';
import 'package:quadycons/data/entities/lat_lng.dart';
import 'package:quadycons/data/entities/project.dart';
import 'package:quadycons/data/services/service.dart';

abstract class ProjectsService {
  Future<List<Project>> getProjects(String accessToken);
}

class ProjectsServiceImpl extends Service implements ProjectsService {
  ProjectsServiceImpl({required super.dio});

  @override
  Future<List<Project>> getProjects(String accessToken) async {
    final response = await super.executeDioService(
      () async => await dio.get(
        'projects/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          }
        )
      )
    );
    final result = response.data as List;
    return result.map((projectData) => Project(
      id: projectData['id'],
      name: projectData['nombre'],
      geoLocation: LatLng(
        lat: projectData['latitud'].toDouble(),
        lon: projectData['longitud'].toDouble(),
      ),
      geoFence: projectData['radio_geocerca'].toDouble(),
    )).toList();
  }
}
