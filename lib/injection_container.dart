import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:quadycons/data/local_data_source/auth_local_data_source.dart';
import 'package:quadycons/data/platform/storage_connector.dart';
import 'package:quadycons/data/repositories/auth_repository_impl.dart';
import 'package:quadycons/data/repositories/code_scan_repository_Impl.dart';
import 'package:quadycons/data/repositories/register_confirmation_repository_impl.dart';
import 'package:quadycons/data/services/auth_service.dart';
import 'package:quadycons/data/services/code_scan_service.dart';
import 'package:quadycons/data/services/register_confirmation_service.dart';
import 'package:quadycons/data/services/fake/auth_service_fake.dart';
import 'package:quadycons/data/services/fake/code_scan_service_fake.dart';
import 'package:quadycons/data/services/fake/register_confirmation_service_fake.dart';
import 'package:quadycons/data/services/geo_location.dart';
import 'package:quadycons/domain/blocs/auth/auth_bloc.dart';
import 'package:quadycons/domain/blocs/code_scan/code_scan_bloc.dart';
import 'package:quadycons/domain/blocs/register_confirmation/register_confirmation_bloc.dart';
import 'package:quadycons/domain/logic/locations_comparer.dart';
import 'package:quadycons/domain/repositories/auth_repository.dart';
import 'package:quadycons/domain/repositories/code_scan_repository.dart';
import 'package:quadycons/domain/repositories/register_confirmation_repository.dart';
import 'package:quadycons/ui/utils/code_scan_adapter.dart';

final sl = GetIt.instance;

void init() {

  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Geolocation>(() => GeoLocationImpl());
  sl.registerLazySingleton<StorageConnector>(
    () => StorageConnectorImpl(
      fss: FlutterSecureStorage()
    )
  );

  // ******************************************
  // Authentication
  // ******************************************
  _initAuthenticationModule();

  // ******************************************
  // Code Scan
  // ******************************************
  _initCodeScanModule();

  // ******************************************
  // Register Confirmation
  // ******************************************
  _initRegisterConfirmationModule();
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
      localDataSource: sl<AuthLocalDataSource>()
    )
  );
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(repository: sl<AuthRepository>())
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
  sl.registerLazySingleton<CodeScanRepository>(
    () => CodeScanRepositoryImpl(
      service: sl<CodeScanService>(),
      accessTokenGetter: sl<AuthLocalDataSource>()
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
  sl.registerLazySingleton<RegisterConfirmationRepository>(
    () => RegisterConfirmationRepositoryImpl(
      registerConfirmationService: sl<RegisterConfirmationService>(),
      accessTokenGetter: sl<AuthLocalDataSource>()
    )
  );
  sl.registerFactory<RegisterConfirmationBloc>(
    () => RegisterConfirmationBloc(
      repository: sl<RegisterConfirmationRepository>()
    )
  );
}

bool useRealData = false;

 T _implementRealOrFake<T>({
  required T realImpl, 
  required T fakeImpl
}) => useRealData? realImpl
                 : fakeImpl; 