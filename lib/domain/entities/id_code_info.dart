class Worker {
  final String? id;
  final String name;
  final String? profileUrl;
  final String? position;
  final int projectId;

  Worker({
    required this.id,
    required this.name,
    required this.profileUrl,
    required this.position,
    required this.projectId
  });

  Worker copyWith({
    String? id,
    String? name,
    String? profileUrl,
    String? position,
    int? projectId
  }) => Worker(
    id: id ?? this.id,
    name: name ?? this.name,
    profileUrl: profileUrl ?? this.profileUrl,
    position: position ?? this.position,
    projectId: projectId ?? this.projectId
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