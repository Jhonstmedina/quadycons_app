import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:quadycons/data/db/app_database.dart';
import 'package:quadycons/data/db/daos/attendance_dao.dart';
import 'package:quadycons/data/db/daos/project_dao.dart';
import 'package:quadycons/data/db/daos/worker_dao.dart';
import 'package:quadycons/data/local_data_source/auth_local_data_source.dart';
import 'package:quadycons/data/local_data_source/summary_local_data_source.dart';
import 'package:quadycons/data/platform/permissions_controller.dart';
import 'package:quadycons/data/platform/storage_connector.dart';
import 'package:quadycons/data/repositories/auth_repository_impl.dart';
import 'package:quadycons/data/repositories/code_scan_repository_Impl.dart';
import 'package:quadycons/data/repositories/projects_repository_impl.dart';
import 'package:quadycons/data/repositories/register_confirmation_repository_impl.dart';
import 'package:quadycons/data/repositories/summary_repository_impl.dart';
import 'package:quadycons/data/services/auth_service.dart';
import 'package:quadycons/data/services/code_scan_service.dart';
import 'package:quadycons/data/services/fake/projects_service_fake.dart';
import 'package:quadycons/data/services/projects_service.dart';
import 'package:quadycons/data/services/register_confirmation_service.dart';
import 'package:quadycons/data/services/fake/auth_service_fake.dart';
import 'package:quadycons/data/services/fake/code_scan_service_fake.dart';
import 'package:quadycons/data/services/fake/register_confirmation_service_fake.dart';
import 'package:quadycons/data/services/geo_location.dart';
import 'package:quadycons/domain/blocs/auth/auth_bloc.dart';
import 'package:quadycons/domain/blocs/code_scan/code_scan_bloc.dart';
import 'package:quadycons/domain/blocs/permissions/permissions_bloc.dart';
import 'package:quadycons/domain/blocs/projects/projects_bloc.dart';
import 'package:quadycons/domain/blocs/register_confirmation/register_confirmation_bloc.dart';
import 'package:quadycons/domain/blocs/summaries/summaries_bloc.dart';
import 'package:quadycons/domain/logic/locations_comparer.dart';
import 'package:quadycons/domain/repositories/auth_repository.dart';
import 'package:quadycons/domain/repositories/code_scan_repository.dart';
import 'package:quadycons/domain/repositories/projects_repository.dart';
import 'package:quadycons/domain/repositories/attendance_repository.dart';
import 'package:quadycons/domain/repositories/summary_repository.dart';
import 'package:quadycons/ui/utils/code_scan_adapter.dart';

final sl = GetIt.instance;

void init() {

  sl.registerLazySingleton<Dio>(() => Dio(
    BaseOptions(
      baseUrl: 'https://34.68.203.103/api',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    )
  ));
  sl.registerLazySingleton<Geolocation>(() => GeoLocationImpl());
  sl.registerLazySingleton<StorageConnector>(
    () => StorageConnectorImpl(
      fss: FlutterSecureStorage()
    )
  );
  sl.registerLazySingleton<AppDatabase>(
    () => AppDatabase()
  );

  // ******************************************
  // Authentication
  // ******************************************
  _initAuthenticationModule();

  // ******************************************
  // Projects
  // ******************************************

  _initProjectsModule();


  // ******************************************
  // Permissions
  // ******************************************

  _initPermissionsModule();

  // ******************************************
  // Code Scan
  // ******************************************
  _initCodeScanModule();

  // ******************************************
  // Register Confirmation
  // ******************************************
  _initRegisterConfirmationModule();

  // ******************************************
  // Summary
  // ******************************************
  _initSummaryModule();
}

void _initAuthenticationModule() {
  sl.registerLazySingleton<AuthService>(
    () => _implementRealOrFake(
      realImpl: AuthServiceImpl(
        dio: sl<Dio>()
      ),
      fakeImpl: AuthServiceFake()
    )
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(
      storageConnector: sl<StorageConnector>()
    )
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authService: sl<AuthService>(),
      localDataSource: sl<AuthLocalDataSource>(),
      dbCleaner: sl<AppDatabase>()
    )
  );
  sl.registerSingleton<AuthBloc>(
    AuthBloc(repository: sl<AuthRepository>())
  );
}

void _initProjectsModule() {
  sl.registerLazySingleton<ProjectsService>(
    () => _implementRealOrFake(
      realImpl: ProjectsServiceImpl(
        dio: sl<Dio>()
      ),
      fakeImpl: ProjectsServiceFake(
        geoLocation: sl<Geolocation>()
      )
    )
  );
  sl.registerLazySingleton<ProjectsDao>(
    () => ProjectsDao(sl<AppDatabase>())
  );
  sl.registerLazySingleton<ProjectsRepository>(
    () => ProjectsRepositoryImpl(
      projectsService: sl<ProjectsService>(),
      localDataSource: sl<AuthLocalDataSource>(),
      dao: sl<ProjectsDao>()
    )
  );
  sl.registerSingleton<ProjectsBloc>(
    ProjectsBloc(
      repository: sl<ProjectsRepository>()
    )
  );
}

void _initPermissionsModule() {
  sl.registerLazySingleton<PermissionsController>(() => PermissionsController());
  sl.registerFactory<PermissionsBloc>(
    () => PermissionsBloc(
      permissionsController: sl<PermissionsController>()
    )
  );
}

void _initCodeScanModule() {
  sl.registerLazySingleton<CodeScanService>(
    () => _implementRealOrFake<CodeScanService>(
      realImpl: CodeScanServiceImpl(
        dio: sl<Dio>()
      ),
      fakeImpl: CodeScanServiceFake(
        geoLocation: sl<Geolocation>()
      )
    )
  );
  sl.registerLazySingleton<WorkersDao>(
    () => WorkersDao(sl<AppDatabase>())
  );
  sl.registerLazySingleton<CodeScanRepository>(
    () => CodeScanRepositoryImpl(
      service: sl<CodeScanService>(),
      accessTokenGetter: sl<AuthLocalDataSource>(),
      dao: sl<WorkersDao>()
    )
  );
  sl.registerFactory<CodeScanBloc>(
    () => CodeScanBloc(
      repository: sl<CodeScanRepository>(),
      geolocation: sl<Geolocation>(),
      locationsComparer: LocationsComparer()
    )
  );
  sl.registerLazySingleton<CodeScanAdapter>(() => CodeScanAdapter());
}

void _initRegisterConfirmationModule() {
  sl.registerLazySingleton<RegisterConfirmationService>(
    () => _implementRealOrFake<RegisterConfirmationService>(
      realImpl: RegisterConfirmationServiceImpl(
        dio: sl<Dio>()
      ),
      fakeImpl: RegisterConfirmationServiceFake()
    )
  );
  sl.registerLazySingleton<AttendanceDao>(
    () => AttendanceDao(sl<AppDatabase>())
  );
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(
      registerConfirmationService: sl<RegisterConfirmationService>(),
      accessTokenGetter: sl<AuthLocalDataSource>(),
      dao: sl<AttendanceDao>()
    )
  );
  sl.registerFactory<RegisterConfirmationBloc>(
    () => RegisterConfirmationBloc(
      repository: sl<AttendanceRepository>()
    )
  );
}

void _initSummaryModule() {
  sl.registerLazySingleton<SummaryLocalDataSource>(
    () => SummaryLocalDataSourceImpl()
  );
  sl.registerLazySingleton<SummaryRepository>(
    () => SummaryRepositoryImpl(
      attendanceDao: sl<AttendanceDao>()
    )
  );
  sl.registerFactory<SummariesBloc>(
    () => SummariesBloc(
      sl<SummaryRepository>()
    )
  );
}

bool useRealData = false;

 T _implementRealOrFake<T>({
  required T realImpl, 
  required T fakeImpl
}) => useRealData? realImpl
                 : fakeImpl;