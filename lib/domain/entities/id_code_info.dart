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
}

class IdCodeInfo {
  final String docNumber;
  final Worker? worker;

  IdCodeInfo({
    required this.docNumber,
    this.worker
  });
}