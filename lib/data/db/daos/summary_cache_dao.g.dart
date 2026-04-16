// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_cache_dao.dart';

// ignore_for_file: type=lint
mixin _$SummaryCacheDaoMixin on DatabaseAccessor<AppDatabase> {
  $SummaryCacheTable get summaryCache => attachedDatabase.summaryCache;
  SummaryCacheDaoManager get managers => SummaryCacheDaoManager(this);
}

class SummaryCacheDaoManager {
  final _$SummaryCacheDaoMixin _db;
  SummaryCacheDaoManager(this._db);
  $$SummaryCacheTableTableManager get summaryCache =>
      $$SummaryCacheTableTableManager(_db.attachedDatabase, _db.summaryCache);
}
