// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _geoFenceMeta = const VerificationMeta(
    'geoFence',
  );
  @override
  late final GeneratedColumn<double> geoFence = GeneratedColumn<double>(
    'geo_fence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    latitude,
    longitude,
    geoFence,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Project> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('geo_fence')) {
      context.handle(
        _geoFenceMeta,
        geoFence.isAcceptableOrUnknown(data['geo_fence']!, _geoFenceMeta),
      );
    } else if (isInserting) {
      context.missing(_geoFenceMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      geoFence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}geo_fence'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final double geoFence;
  final bool synced;
  const Project({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.geoFence,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['geo_fence'] = Variable<double>(geoFence);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      latitude: Value(latitude),
      longitude: Value(longitude),
      geoFence: Value(geoFence),
      synced: Value(synced),
    );
  }

  factory Project.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      geoFence: serializer.fromJson<double>(json['geoFence']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'geoFence': serializer.toJson<double>(geoFence),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  Project copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    double? geoFence,
    bool? synced,
  }) => Project(
    id: id ?? this.id,
    name: name ?? this.name,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    geoFence: geoFence ?? this.geoFence,
    synced: synced ?? this.synced,
  );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      geoFence: data.geoFence.present ? data.geoFence.value : this.geoFence,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('geoFence: $geoFence, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, latitude, longitude, geoFence, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.name == this.name &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.geoFence == this.geoFence &&
          other.synced == this.synced);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> geoFence;
  final Value<bool> synced;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.geoFence = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required int id,
    required String name,
    required double latitude,
    required double longitude,
    required double geoFence,
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       latitude = Value(latitude),
       longitude = Value(longitude),
       geoFence = Value(geoFence);
  static Insertable<Project> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? geoFence,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (geoFence != null) 'geo_fence': geoFence,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double>? geoFence,
    Value<bool>? synced,
    Value<int>? rowid,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      geoFence: geoFence ?? this.geoFence,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (geoFence.present) {
      map['geo_fence'] = Variable<double>(geoFence.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('geoFence: $geoFence, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkersTable extends Workers with TableInfo<$WorkersTable, Worker> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileUrlMeta = const VerificationMeta(
    'profileUrl',
  );
  @override
  late final GeneratedColumn<String> profileUrl = GeneratedColumn<String>(
    'profile_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _docNumberMeta = const VerificationMeta(
    'docNumber',
  );
  @override
  late final GeneratedColumn<String> docNumber = GeneratedColumn<String>(
    'doc_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    profileUrl,
    position,
    docNumber,
    projectId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Worker> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('profile_url')) {
      context.handle(
        _profileUrlMeta,
        profileUrl.isAcceptableOrUnknown(data['profile_url']!, _profileUrlMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('doc_number')) {
      context.handle(
        _docNumberMeta,
        docNumber.isAcceptableOrUnknown(data['doc_number']!, _docNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_docNumberMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Worker map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Worker(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      profileUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_url'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      ),
      docNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doc_number'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      )!,
    );
  }

  @override
  $WorkersTable createAlias(String alias) {
    return $WorkersTable(attachedDatabase, alias);
  }
}

class Worker extends DataClass implements Insertable<Worker> {
  final String? id;
  final String name;
  final String? profileUrl;
  final String? position;
  final String docNumber;
  final int projectId;
  const Worker({
    this.id,
    required this.name,
    this.profileUrl,
    this.position,
    required this.docNumber,
    required this.projectId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || profileUrl != null) {
      map['profile_url'] = Variable<String>(profileUrl);
    }
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    map['doc_number'] = Variable<String>(docNumber);
    map['project_id'] = Variable<int>(projectId);
    return map;
  }

  WorkersCompanion toCompanion(bool nullToAbsent) {
    return WorkersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      profileUrl: profileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(profileUrl),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      docNumber: Value(docNumber),
      projectId: Value(projectId),
    );
  }

  factory Worker.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Worker(
      id: serializer.fromJson<String?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      profileUrl: serializer.fromJson<String?>(json['profileUrl']),
      position: serializer.fromJson<String?>(json['position']),
      docNumber: serializer.fromJson<String>(json['docNumber']),
      projectId: serializer.fromJson<int>(json['projectId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'name': serializer.toJson<String>(name),
      'profileUrl': serializer.toJson<String?>(profileUrl),
      'position': serializer.toJson<String?>(position),
      'docNumber': serializer.toJson<String>(docNumber),
      'projectId': serializer.toJson<int>(projectId),
    };
  }

  Worker copyWith({
    Value<String?> id = const Value.absent(),
    String? name,
    Value<String?> profileUrl = const Value.absent(),
    Value<String?> position = const Value.absent(),
    String? docNumber,
    int? projectId,
  }) => Worker(
    id: id.present ? id.value : this.id,
    name: name ?? this.name,
    profileUrl: profileUrl.present ? profileUrl.value : this.profileUrl,
    position: position.present ? position.value : this.position,
    docNumber: docNumber ?? this.docNumber,
    projectId: projectId ?? this.projectId,
  );
  Worker copyWithCompanion(WorkersCompanion data) {
    return Worker(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      profileUrl: data.profileUrl.present
          ? data.profileUrl.value
          : this.profileUrl,
      position: data.position.present ? data.position.value : this.position,
      docNumber: data.docNumber.present ? data.docNumber.value : this.docNumber,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Worker(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('profileUrl: $profileUrl, ')
          ..write('position: $position, ')
          ..write('docNumber: $docNumber, ')
          ..write('projectId: $projectId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, profileUrl, position, docNumber, projectId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Worker &&
          other.id == this.id &&
          other.name == this.name &&
          other.profileUrl == this.profileUrl &&
          other.position == this.position &&
          other.docNumber == this.docNumber &&
          other.projectId == this.projectId);
}

class WorkersCompanion extends UpdateCompanion<Worker> {
  final Value<String?> id;
  final Value<String> name;
  final Value<String?> profileUrl;
  final Value<String?> position;
  final Value<String> docNumber;
  final Value<int> projectId;
  final Value<int> rowid;
  const WorkersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.profileUrl = const Value.absent(),
    this.position = const Value.absent(),
    this.docNumber = const Value.absent(),
    this.projectId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.profileUrl = const Value.absent(),
    this.position = const Value.absent(),
    required String docNumber,
    required int projectId,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       docNumber = Value(docNumber),
       projectId = Value(projectId);
  static Insertable<Worker> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? profileUrl,
    Expression<String>? position,
    Expression<String>? docNumber,
    Expression<int>? projectId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (profileUrl != null) 'profile_url': profileUrl,
      if (position != null) 'position': position,
      if (docNumber != null) 'doc_number': docNumber,
      if (projectId != null) 'project_id': projectId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkersCompanion copyWith({
    Value<String?>? id,
    Value<String>? name,
    Value<String?>? profileUrl,
    Value<String?>? position,
    Value<String>? docNumber,
    Value<int>? projectId,
    Value<int>? rowid,
  }) {
    return WorkersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      profileUrl: profileUrl ?? this.profileUrl,
      position: position ?? this.position,
      docNumber: docNumber ?? this.docNumber,
      projectId: projectId ?? this.projectId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (profileUrl.present) {
      map['profile_url'] = Variable<String>(profileUrl.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (docNumber.present) {
      map['doc_number'] = Variable<String>(docNumber.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('profileUrl: $profileUrl, ')
          ..write('position: $position, ')
          ..write('docNumber: $docNumber, ')
          ..write('projectId: $projectId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendancesTable extends Attendances
    with TableInfo<$AttendancesTable, Attendance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idCodeDocNumberMeta = const VerificationMeta(
    'idCodeDocNumber',
  );
  @override
  late final GeneratedColumn<String> idCodeDocNumber = GeneratedColumn<String>(
    'id_code_doc_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workers (doc_number)',
    ),
  );
  static const VerificationMeta _checkInDateMeta = const VerificationMeta(
    'checkInDate',
  );
  @override
  late final GeneratedColumn<DateTime> checkInDate = GeneratedColumn<DateTime>(
    'check_in_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkInLatMeta = const VerificationMeta(
    'checkInLat',
  );
  @override
  late final GeneratedColumn<double> checkInLat = GeneratedColumn<double>(
    'check_in_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkInLonMeta = const VerificationMeta(
    'checkInLon',
  );
  @override
  late final GeneratedColumn<double> checkInLon = GeneratedColumn<double>(
    'check_in_lon',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkOutDateMeta = const VerificationMeta(
    'checkOutDate',
  );
  @override
  late final GeneratedColumn<DateTime> checkOutDate = GeneratedColumn<DateTime>(
    'check_out_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkOutLatMeta = const VerificationMeta(
    'checkOutLat',
  );
  @override
  late final GeneratedColumn<double> checkOutLat = GeneratedColumn<double>(
    'check_out_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkOutLonMeta = const VerificationMeta(
    'checkOutLon',
  );
  @override
  late final GeneratedColumn<double> checkOutLon = GeneratedColumn<double>(
    'check_out_lon',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    idCodeDocNumber,
    checkInDate,
    checkInLat,
    checkInLon,
    checkOutDate,
    checkOutLat,
    checkOutLon,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendances';
  @override
  VerificationContext validateIntegrity(
    Insertable<Attendance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('id_code_doc_number')) {
      context.handle(
        _idCodeDocNumberMeta,
        idCodeDocNumber.isAcceptableOrUnknown(
          data['id_code_doc_number']!,
          _idCodeDocNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idCodeDocNumberMeta);
    }
    if (data.containsKey('check_in_date')) {
      context.handle(
        _checkInDateMeta,
        checkInDate.isAcceptableOrUnknown(
          data['check_in_date']!,
          _checkInDateMeta,
        ),
      );
    }
    if (data.containsKey('check_in_lat')) {
      context.handle(
        _checkInLatMeta,
        checkInLat.isAcceptableOrUnknown(
          data['check_in_lat']!,
          _checkInLatMeta,
        ),
      );
    }
    if (data.containsKey('check_in_lon')) {
      context.handle(
        _checkInLonMeta,
        checkInLon.isAcceptableOrUnknown(
          data['check_in_lon']!,
          _checkInLonMeta,
        ),
      );
    }
    if (data.containsKey('check_out_date')) {
      context.handle(
        _checkOutDateMeta,
        checkOutDate.isAcceptableOrUnknown(
          data['check_out_date']!,
          _checkOutDateMeta,
        ),
      );
    }
    if (data.containsKey('check_out_lat')) {
      context.handle(
        _checkOutLatMeta,
        checkOutLat.isAcceptableOrUnknown(
          data['check_out_lat']!,
          _checkOutLatMeta,
        ),
      );
    }
    if (data.containsKey('check_out_lon')) {
      context.handle(
        _checkOutLonMeta,
        checkOutLon.isAcceptableOrUnknown(
          data['check_out_lon']!,
          _checkOutLonMeta,
        ),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attendance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attendance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      idCodeDocNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_code_doc_number'],
      )!,
      checkInDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_in_date'],
      ),
      checkInLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}check_in_lat'],
      ),
      checkInLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}check_in_lon'],
      ),
      checkOutDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_out_date'],
      ),
      checkOutLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}check_out_lat'],
      ),
      checkOutLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}check_out_lon'],
      ),
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $AttendancesTable createAlias(String alias) {
    return $AttendancesTable(attachedDatabase, alias);
  }
}

class Attendance extends DataClass implements Insertable<Attendance> {
  final int id;
  final int? remoteId;
  final String idCodeDocNumber;
  final DateTime? checkInDate;
  final double? checkInLat;
  final double? checkInLon;
  final DateTime? checkOutDate;
  final double? checkOutLat;
  final double? checkOutLon;
  final bool synced;
  const Attendance({
    required this.id,
    this.remoteId,
    required this.idCodeDocNumber,
    this.checkInDate,
    this.checkInLat,
    this.checkInLon,
    this.checkOutDate,
    this.checkOutLat,
    this.checkOutLon,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['id_code_doc_number'] = Variable<String>(idCodeDocNumber);
    if (!nullToAbsent || checkInDate != null) {
      map['check_in_date'] = Variable<DateTime>(checkInDate);
    }
    if (!nullToAbsent || checkInLat != null) {
      map['check_in_lat'] = Variable<double>(checkInLat);
    }
    if (!nullToAbsent || checkInLon != null) {
      map['check_in_lon'] = Variable<double>(checkInLon);
    }
    if (!nullToAbsent || checkOutDate != null) {
      map['check_out_date'] = Variable<DateTime>(checkOutDate);
    }
    if (!nullToAbsent || checkOutLat != null) {
      map['check_out_lat'] = Variable<double>(checkOutLat);
    }
    if (!nullToAbsent || checkOutLon != null) {
      map['check_out_lon'] = Variable<double>(checkOutLon);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  AttendancesCompanion toCompanion(bool nullToAbsent) {
    return AttendancesCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      idCodeDocNumber: Value(idCodeDocNumber),
      checkInDate: checkInDate == null && nullToAbsent
          ? const Value.absent()
          : Value(checkInDate),
      checkInLat: checkInLat == null && nullToAbsent
          ? const Value.absent()
          : Value(checkInLat),
      checkInLon: checkInLon == null && nullToAbsent
          ? const Value.absent()
          : Value(checkInLon),
      checkOutDate: checkOutDate == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOutDate),
      checkOutLat: checkOutLat == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOutLat),
      checkOutLon: checkOutLon == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOutLon),
      synced: Value(synced),
    );
  }

  factory Attendance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attendance(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      idCodeDocNumber: serializer.fromJson<String>(json['idCodeDocNumber']),
      checkInDate: serializer.fromJson<DateTime?>(json['checkInDate']),
      checkInLat: serializer.fromJson<double?>(json['checkInLat']),
      checkInLon: serializer.fromJson<double?>(json['checkInLon']),
      checkOutDate: serializer.fromJson<DateTime?>(json['checkOutDate']),
      checkOutLat: serializer.fromJson<double?>(json['checkOutLat']),
      checkOutLon: serializer.fromJson<double?>(json['checkOutLon']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'idCodeDocNumber': serializer.toJson<String>(idCodeDocNumber),
      'checkInDate': serializer.toJson<DateTime?>(checkInDate),
      'checkInLat': serializer.toJson<double?>(checkInLat),
      'checkInLon': serializer.toJson<double?>(checkInLon),
      'checkOutDate': serializer.toJson<DateTime?>(checkOutDate),
      'checkOutLat': serializer.toJson<double?>(checkOutLat),
      'checkOutLon': serializer.toJson<double?>(checkOutLon),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  Attendance copyWith({
    int? id,
    Value<int?> remoteId = const Value.absent(),
    String? idCodeDocNumber,
    Value<DateTime?> checkInDate = const Value.absent(),
    Value<double?> checkInLat = const Value.absent(),
    Value<double?> checkInLon = const Value.absent(),
    Value<DateTime?> checkOutDate = const Value.absent(),
    Value<double?> checkOutLat = const Value.absent(),
    Value<double?> checkOutLon = const Value.absent(),
    bool? synced,
  }) => Attendance(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    idCodeDocNumber: idCodeDocNumber ?? this.idCodeDocNumber,
    checkInDate: checkInDate.present ? checkInDate.value : this.checkInDate,
    checkInLat: checkInLat.present ? checkInLat.value : this.checkInLat,
    checkInLon: checkInLon.present ? checkInLon.value : this.checkInLon,
    checkOutDate: checkOutDate.present ? checkOutDate.value : this.checkOutDate,
    checkOutLat: checkOutLat.present ? checkOutLat.value : this.checkOutLat,
    checkOutLon: checkOutLon.present ? checkOutLon.value : this.checkOutLon,
    synced: synced ?? this.synced,
  );
  Attendance copyWithCompanion(AttendancesCompanion data) {
    return Attendance(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      idCodeDocNumber: data.idCodeDocNumber.present
          ? data.idCodeDocNumber.value
          : this.idCodeDocNumber,
      checkInDate: data.checkInDate.present
          ? data.checkInDate.value
          : this.checkInDate,
      checkInLat: data.checkInLat.present
          ? data.checkInLat.value
          : this.checkInLat,
      checkInLon: data.checkInLon.present
          ? data.checkInLon.value
          : this.checkInLon,
      checkOutDate: data.checkOutDate.present
          ? data.checkOutDate.value
          : this.checkOutDate,
      checkOutLat: data.checkOutLat.present
          ? data.checkOutLat.value
          : this.checkOutLat,
      checkOutLon: data.checkOutLon.present
          ? data.checkOutLon.value
          : this.checkOutLon,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attendance(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('idCodeDocNumber: $idCodeDocNumber, ')
          ..write('checkInDate: $checkInDate, ')
          ..write('checkInLat: $checkInLat, ')
          ..write('checkInLon: $checkInLon, ')
          ..write('checkOutDate: $checkOutDate, ')
          ..write('checkOutLat: $checkOutLat, ')
          ..write('checkOutLon: $checkOutLon, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    idCodeDocNumber,
    checkInDate,
    checkInLat,
    checkInLon,
    checkOutDate,
    checkOutLat,
    checkOutLon,
    synced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attendance &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.idCodeDocNumber == this.idCodeDocNumber &&
          other.checkInDate == this.checkInDate &&
          other.checkInLat == this.checkInLat &&
          other.checkInLon == this.checkInLon &&
          other.checkOutDate == this.checkOutDate &&
          other.checkOutLat == this.checkOutLat &&
          other.checkOutLon == this.checkOutLon &&
          other.synced == this.synced);
}

class AttendancesCompanion extends UpdateCompanion<Attendance> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<String> idCodeDocNumber;
  final Value<DateTime?> checkInDate;
  final Value<double?> checkInLat;
  final Value<double?> checkInLon;
  final Value<DateTime?> checkOutDate;
  final Value<double?> checkOutLat;
  final Value<double?> checkOutLon;
  final Value<bool> synced;
  const AttendancesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.idCodeDocNumber = const Value.absent(),
    this.checkInDate = const Value.absent(),
    this.checkInLat = const Value.absent(),
    this.checkInLon = const Value.absent(),
    this.checkOutDate = const Value.absent(),
    this.checkOutLat = const Value.absent(),
    this.checkOutLon = const Value.absent(),
    this.synced = const Value.absent(),
  });
  AttendancesCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String idCodeDocNumber,
    this.checkInDate = const Value.absent(),
    this.checkInLat = const Value.absent(),
    this.checkInLon = const Value.absent(),
    this.checkOutDate = const Value.absent(),
    this.checkOutLat = const Value.absent(),
    this.checkOutLon = const Value.absent(),
    this.synced = const Value.absent(),
  }) : idCodeDocNumber = Value(idCodeDocNumber);
  static Insertable<Attendance> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? idCodeDocNumber,
    Expression<DateTime>? checkInDate,
    Expression<double>? checkInLat,
    Expression<double>? checkInLon,
    Expression<DateTime>? checkOutDate,
    Expression<double>? checkOutLat,
    Expression<double>? checkOutLon,
    Expression<bool>? synced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (idCodeDocNumber != null) 'id_code_doc_number': idCodeDocNumber,
      if (checkInDate != null) 'check_in_date': checkInDate,
      if (checkInLat != null) 'check_in_lat': checkInLat,
      if (checkInLon != null) 'check_in_lon': checkInLon,
      if (checkOutDate != null) 'check_out_date': checkOutDate,
      if (checkOutLat != null) 'check_out_lat': checkOutLat,
      if (checkOutLon != null) 'check_out_lon': checkOutLon,
      if (synced != null) 'synced': synced,
    });
  }

  AttendancesCompanion copyWith({
    Value<int>? id,
    Value<int?>? remoteId,
    Value<String>? idCodeDocNumber,
    Value<DateTime?>? checkInDate,
    Value<double?>? checkInLat,
    Value<double?>? checkInLon,
    Value<DateTime?>? checkOutDate,
    Value<double?>? checkOutLat,
    Value<double?>? checkOutLon,
    Value<bool>? synced,
  }) {
    return AttendancesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      idCodeDocNumber: idCodeDocNumber ?? this.idCodeDocNumber,
      checkInDate: checkInDate ?? this.checkInDate,
      checkInLat: checkInLat ?? this.checkInLat,
      checkInLon: checkInLon ?? this.checkInLon,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      checkOutLat: checkOutLat ?? this.checkOutLat,
      checkOutLon: checkOutLon ?? this.checkOutLon,
      synced: synced ?? this.synced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (idCodeDocNumber.present) {
      map['id_code_doc_number'] = Variable<String>(idCodeDocNumber.value);
    }
    if (checkInDate.present) {
      map['check_in_date'] = Variable<DateTime>(checkInDate.value);
    }
    if (checkInLat.present) {
      map['check_in_lat'] = Variable<double>(checkInLat.value);
    }
    if (checkInLon.present) {
      map['check_in_lon'] = Variable<double>(checkInLon.value);
    }
    if (checkOutDate.present) {
      map['check_out_date'] = Variable<DateTime>(checkOutDate.value);
    }
    if (checkOutLat.present) {
      map['check_out_lat'] = Variable<double>(checkOutLat.value);
    }
    if (checkOutLon.present) {
      map['check_out_lon'] = Variable<double>(checkOutLon.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendancesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('idCodeDocNumber: $idCodeDocNumber, ')
          ..write('checkInDate: $checkInDate, ')
          ..write('checkInLat: $checkInLat, ')
          ..write('checkInLon: $checkInLon, ')
          ..write('checkOutDate: $checkOutDate, ')
          ..write('checkOutLat: $checkOutLat, ')
          ..write('checkOutLon: $checkOutLon, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $WorkersTable workers = $WorkersTable(this);
  late final $AttendancesTable attendances = $AttendancesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projects,
    workers,
    attendances,
  ];
}

typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      required int id,
      required String name,
      required double latitude,
      required double longitude,
      required double geoFence,
      Value<bool> synced,
      Value<int> rowid,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> latitude,
      Value<double> longitude,
      Value<double> geoFence,
      Value<bool> synced,
      Value<int> rowid,
    });

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, Project> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkersTable, List<Worker>> _workersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.workers,
    aliasName: $_aliasNameGenerator(db.projects.id, db.workers.projectId),
  );

  $$WorkersTableProcessedTableManager get workersRefs {
    final manager = $$WorkersTableTableManager(
      $_db,
      $_db.workers,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get geoFence => $composableBuilder(
    column: $table.geoFence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> workersRefs(
    Expression<bool> Function($$WorkersTableFilterComposer f) f,
  ) {
    final $$WorkersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workers,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkersTableFilterComposer(
            $db: $db,
            $table: $db.workers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get geoFence => $composableBuilder(
    column: $table.geoFence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get geoFence =>
      $composableBuilder(column: $table.geoFence, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  Expression<T> workersRefs<T extends Object>(
    Expression<T> Function($$WorkersTableAnnotationComposer a) f,
  ) {
    final $$WorkersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workers,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkersTableAnnotationComposer(
            $db: $db,
            $table: $db.workers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          Project,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (Project, $$ProjectsTableReferences),
          Project,
          PrefetchHooks Function({bool workersRefs})
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double> geoFence = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                name: name,
                latitude: latitude,
                longitude: longitude,
                geoFence: geoFence,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required String name,
                required double latitude,
                required double longitude,
                required double geoFence,
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                name: name,
                latitude: latitude,
                longitude: longitude,
                geoFence: geoFence,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (workersRefs) db.workers],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workersRefs)
                    await $_getPrefetchedData<Project, $ProjectsTable, Worker>(
                      currentTable: table,
                      referencedTable: $$ProjectsTableReferences
                          ._workersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProjectsTableReferences(db, table, p0).workersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.projectId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      Project,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (Project, $$ProjectsTableReferences),
      Project,
      PrefetchHooks Function({bool workersRefs})
    >;
typedef $$WorkersTableCreateCompanionBuilder =
    WorkersCompanion Function({
      Value<String?> id,
      required String name,
      Value<String?> profileUrl,
      Value<String?> position,
      required String docNumber,
      required int projectId,
      Value<int> rowid,
    });
typedef $$WorkersTableUpdateCompanionBuilder =
    WorkersCompanion Function({
      Value<String?> id,
      Value<String> name,
      Value<String?> profileUrl,
      Value<String?> position,
      Value<String> docNumber,
      Value<int> projectId,
      Value<int> rowid,
    });

final class $$WorkersTableReferences
    extends BaseReferences<_$AppDatabase, $WorkersTable, Worker> {
  $$WorkersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) => db.projects
      .createAlias($_aliasNameGenerator(db.workers.projectId, db.projects.id));

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AttendancesTable, List<Attendance>>
  _attendancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.attendances,
    aliasName: $_aliasNameGenerator(
      db.workers.docNumber,
      db.attendances.idCodeDocNumber,
    ),
  );

  $$AttendancesTableProcessedTableManager get attendancesRefs {
    final manager = $$AttendancesTableTableManager($_db, $_db.attendances)
        .filter(
          (f) => f.idCodeDocNumber.docNumber.sqlEquals(
            $_itemColumn<String>('doc_number')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_attendancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkersTableFilterComposer
    extends Composer<_$AppDatabase, $WorkersTable> {
  $$WorkersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileUrl => $composableBuilder(
    column: $table.profileUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get docNumber => $composableBuilder(
    column: $table.docNumber,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> attendancesRefs(
    Expression<bool> Function($$AttendancesTableFilterComposer f) f,
  ) {
    final $$AttendancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.docNumber,
      referencedTable: $db.attendances,
      getReferencedColumn: (t) => t.idCodeDocNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendancesTableFilterComposer(
            $db: $db,
            $table: $db.attendances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkersTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkersTable> {
  $$WorkersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileUrl => $composableBuilder(
    column: $table.profileUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get docNumber => $composableBuilder(
    column: $table.docNumber,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkersTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkersTable> {
  $$WorkersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get profileUrl => $composableBuilder(
    column: $table.profileUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get docNumber =>
      $composableBuilder(column: $table.docNumber, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> attendancesRefs<T extends Object>(
    Expression<T> Function($$AttendancesTableAnnotationComposer a) f,
  ) {
    final $$AttendancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.docNumber,
      referencedTable: $db.attendances,
      getReferencedColumn: (t) => t.idCodeDocNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendancesTableAnnotationComposer(
            $db: $db,
            $table: $db.attendances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkersTable,
          Worker,
          $$WorkersTableFilterComposer,
          $$WorkersTableOrderingComposer,
          $$WorkersTableAnnotationComposer,
          $$WorkersTableCreateCompanionBuilder,
          $$WorkersTableUpdateCompanionBuilder,
          (Worker, $$WorkersTableReferences),
          Worker,
          PrefetchHooks Function({bool projectId, bool attendancesRefs})
        > {
  $$WorkersTableTableManager(_$AppDatabase db, $WorkersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> profileUrl = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<String> docNumber = const Value.absent(),
                Value<int> projectId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkersCompanion(
                id: id,
                name: name,
                profileUrl: profileUrl,
                position: position,
                docNumber: docNumber,
                projectId: projectId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String?> id = const Value.absent(),
                required String name,
                Value<String?> profileUrl = const Value.absent(),
                Value<String?> position = const Value.absent(),
                required String docNumber,
                required int projectId,
                Value<int> rowid = const Value.absent(),
              }) => WorkersCompanion.insert(
                id: id,
                name: name,
                profileUrl: profileUrl,
                position: position,
                docNumber: docNumber,
                projectId: projectId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({projectId = false, attendancesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (attendancesRefs) db.attendances,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable: $$WorkersTableReferences
                                        ._projectIdTable(db),
                                    referencedColumn: $$WorkersTableReferences
                                        ._projectIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (attendancesRefs)
                        await $_getPrefetchedData<
                          Worker,
                          $WorkersTable,
                          Attendance
                        >(
                          currentTable: table,
                          referencedTable: $$WorkersTableReferences
                              ._attendancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkersTableReferences(
                                db,
                                table,
                                p0,
                              ).attendancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.idCodeDocNumber == item.docNumber,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WorkersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkersTable,
      Worker,
      $$WorkersTableFilterComposer,
      $$WorkersTableOrderingComposer,
      $$WorkersTableAnnotationComposer,
      $$WorkersTableCreateCompanionBuilder,
      $$WorkersTableUpdateCompanionBuilder,
      (Worker, $$WorkersTableReferences),
      Worker,
      PrefetchHooks Function({bool projectId, bool attendancesRefs})
    >;
typedef $$AttendancesTableCreateCompanionBuilder =
    AttendancesCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      required String idCodeDocNumber,
      Value<DateTime?> checkInDate,
      Value<double?> checkInLat,
      Value<double?> checkInLon,
      Value<DateTime?> checkOutDate,
      Value<double?> checkOutLat,
      Value<double?> checkOutLon,
      Value<bool> synced,
    });
typedef $$AttendancesTableUpdateCompanionBuilder =
    AttendancesCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      Value<String> idCodeDocNumber,
      Value<DateTime?> checkInDate,
      Value<double?> checkInLat,
      Value<double?> checkInLon,
      Value<DateTime?> checkOutDate,
      Value<double?> checkOutLat,
      Value<double?> checkOutLon,
      Value<bool> synced,
    });

final class $$AttendancesTableReferences
    extends BaseReferences<_$AppDatabase, $AttendancesTable, Attendance> {
  $$AttendancesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkersTable _idCodeDocNumberTable(_$AppDatabase db) =>
      db.workers.createAlias(
        $_aliasNameGenerator(
          db.attendances.idCodeDocNumber,
          db.workers.docNumber,
        ),
      );

  $$WorkersTableProcessedTableManager get idCodeDocNumber {
    final $_column = $_itemColumn<String>('id_code_doc_number')!;

    final manager = $$WorkersTableTableManager(
      $_db,
      $_db.workers,
    ).filter((f) => f.docNumber.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idCodeDocNumberTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttendancesTableFilterComposer
    extends Composer<_$AppDatabase, $AttendancesTable> {
  $$AttendancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkInDate => $composableBuilder(
    column: $table.checkInDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get checkInLat => $composableBuilder(
    column: $table.checkInLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get checkInLon => $composableBuilder(
    column: $table.checkInLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkOutDate => $composableBuilder(
    column: $table.checkOutDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get checkOutLat => $composableBuilder(
    column: $table.checkOutLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get checkOutLon => $composableBuilder(
    column: $table.checkOutLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkersTableFilterComposer get idCodeDocNumber {
    final $$WorkersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idCodeDocNumber,
      referencedTable: $db.workers,
      getReferencedColumn: (t) => t.docNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkersTableFilterComposer(
            $db: $db,
            $table: $db.workers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendancesTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendancesTable> {
  $$AttendancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkInDate => $composableBuilder(
    column: $table.checkInDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get checkInLat => $composableBuilder(
    column: $table.checkInLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get checkInLon => $composableBuilder(
    column: $table.checkInLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkOutDate => $composableBuilder(
    column: $table.checkOutDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get checkOutLat => $composableBuilder(
    column: $table.checkOutLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get checkOutLon => $composableBuilder(
    column: $table.checkOutLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkersTableOrderingComposer get idCodeDocNumber {
    final $$WorkersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idCodeDocNumber,
      referencedTable: $db.workers,
      getReferencedColumn: (t) => t.docNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkersTableOrderingComposer(
            $db: $db,
            $table: $db.workers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendancesTable> {
  $$AttendancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get checkInDate => $composableBuilder(
    column: $table.checkInDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get checkInLat => $composableBuilder(
    column: $table.checkInLat,
    builder: (column) => column,
  );

  GeneratedColumn<double> get checkInLon => $composableBuilder(
    column: $table.checkInLon,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get checkOutDate => $composableBuilder(
    column: $table.checkOutDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get checkOutLat => $composableBuilder(
    column: $table.checkOutLat,
    builder: (column) => column,
  );

  GeneratedColumn<double> get checkOutLon => $composableBuilder(
    column: $table.checkOutLon,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  $$WorkersTableAnnotationComposer get idCodeDocNumber {
    final $$WorkersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idCodeDocNumber,
      referencedTable: $db.workers,
      getReferencedColumn: (t) => t.docNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkersTableAnnotationComposer(
            $db: $db,
            $table: $db.workers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendancesTable,
          Attendance,
          $$AttendancesTableFilterComposer,
          $$AttendancesTableOrderingComposer,
          $$AttendancesTableAnnotationComposer,
          $$AttendancesTableCreateCompanionBuilder,
          $$AttendancesTableUpdateCompanionBuilder,
          (Attendance, $$AttendancesTableReferences),
          Attendance,
          PrefetchHooks Function({bool idCodeDocNumber})
        > {
  $$AttendancesTableTableManager(_$AppDatabase db, $AttendancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> idCodeDocNumber = const Value.absent(),
                Value<DateTime?> checkInDate = const Value.absent(),
                Value<double?> checkInLat = const Value.absent(),
                Value<double?> checkInLon = const Value.absent(),
                Value<DateTime?> checkOutDate = const Value.absent(),
                Value<double?> checkOutLat = const Value.absent(),
                Value<double?> checkOutLon = const Value.absent(),
                Value<bool> synced = const Value.absent(),
              }) => AttendancesCompanion(
                id: id,
                remoteId: remoteId,
                idCodeDocNumber: idCodeDocNumber,
                checkInDate: checkInDate,
                checkInLat: checkInLat,
                checkInLon: checkInLon,
                checkOutDate: checkOutDate,
                checkOutLat: checkOutLat,
                checkOutLon: checkOutLon,
                synced: synced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String idCodeDocNumber,
                Value<DateTime?> checkInDate = const Value.absent(),
                Value<double?> checkInLat = const Value.absent(),
                Value<double?> checkInLon = const Value.absent(),
                Value<DateTime?> checkOutDate = const Value.absent(),
                Value<double?> checkOutLat = const Value.absent(),
                Value<double?> checkOutLon = const Value.absent(),
                Value<bool> synced = const Value.absent(),
              }) => AttendancesCompanion.insert(
                id: id,
                remoteId: remoteId,
                idCodeDocNumber: idCodeDocNumber,
                checkInDate: checkInDate,
                checkInLat: checkInLat,
                checkInLon: checkInLon,
                checkOutDate: checkOutDate,
                checkOutLat: checkOutLat,
                checkOutLon: checkOutLon,
                synced: synced,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AttendancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({idCodeDocNumber = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (idCodeDocNumber) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.idCodeDocNumber,
                                referencedTable: $$AttendancesTableReferences
                                    ._idCodeDocNumberTable(db),
                                referencedColumn: $$AttendancesTableReferences
                                    ._idCodeDocNumberTable(db)
                                    .docNumber,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttendancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendancesTable,
      Attendance,
      $$AttendancesTableFilterComposer,
      $$AttendancesTableOrderingComposer,
      $$AttendancesTableAnnotationComposer,
      $$AttendancesTableCreateCompanionBuilder,
      $$AttendancesTableUpdateCompanionBuilder,
      (Attendance, $$AttendancesTableReferences),
      Attendance,
      PrefetchHooks Function({bool idCodeDocNumber})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$WorkersTableTableManager get workers =>
      $$WorkersTableTableManager(_db, _db.workers);
  $$AttendancesTableTableManager get attendances =>
      $$AttendancesTableTableManager(_db, _db.attendances);
}
