import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/project.dart';
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
        'proyectos/',
        options: super.getBaseOptions(accessToken),
        queryParameters: {
          'activo': true
        }
      )
    );
    final result = response.data as List;
    try{
      return result.map((projectData) {
        final lat = projectData['latitud'];
        final lon = projectData['longitud'];
        return Project(
          id: projectData['id'],
          name: projectData['nombre'],
          geoLocation: lat != null && lon != null ? LatLng(
            lat: double.parse(lat.toString()),
            lon: double.parse(lon.toString()),
          ): null,
          geoFence: double.parse(projectData['radio_geovalla'].toString())
        );
      }).toList();
    } catch (exception, stackTrace) {
      print('Error parsing projects: $exception');
      print(stackTrace);
      rethrow;
    }
  }
}
