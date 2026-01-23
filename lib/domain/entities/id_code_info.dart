
import 'package:quadycons/domain/entities/project.dart';

class Worker {
  final String? id;
  final String name;
  final String? profileUrl;
  final String? position;
  final Project? project;

  Worker({
    required this.id,
    required this.name,
    required this.profileUrl,
    required this.position,
    required this.project
  });

  Worker copyWith({
    String? id,
    String? name,
    String? profileUrl,
    String? position,
    Project? projectId
  }) => Worker(
    id: id ?? this.id,
    name: name ?? this.name,
    profileUrl: profileUrl ?? this.profileUrl,
    position: position ?? this.position,
    project: projectId ?? this.project
  );
}

class IdCodeInfo {
  final String docNumber;
  final Worker? worker;

  IdCodeInfo({
    required this.docNumber,
    this.worker
  });

  IdCodeInfo copyWith({
    String? docNumber,
    Worker? worker
  }) =>IdCodeInfo(
    docNumber: docNumber ?? this.docNumber,
    worker: worker ?? this.worker
  );
}