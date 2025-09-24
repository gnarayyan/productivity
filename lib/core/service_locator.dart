import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varosa_tech/core/constants/api_constants.dart';

// Productivity app imports
import '../features/personal_productivity/shared/presentation/blocs/productivity_navigation_bloc/productivity_navigation_bloc.dart';
import 'auth/bloc/auth_bloc.dart';
// Auth imports
import 'auth/data/datasources/auth_local_data_source.dart';
import 'auth/data/datasources/auth_remote_data_source.dart';
import 'auth/data/repositories/auth_repository_impl.dart';
import 'auth/di/auth_di.dart';
import 'auth/domain/repositories/auth_repository.dart';
import 'auth/services/token_refresh_service.dart';
import 'services/api_service.dart';
// Theme imports
import 'themes/bloc/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  // sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Register Dio
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: ApiConstants.baseUrl)),
  );

  // Register API Service
  sl.registerLazySingleton<ApiService>(() => ApiService(dio: sl<Dio>()));

  // Productivity App Dependencies
  sl.registerFactory(ProductivityNavigationBloc.new);

  // Auth App Dependencies
  await _setupAuthDependencies();

  // Register Auth DI
  AuthDI.registerDependencies(sl);
}

Future<void> _setupAuthDependencies() async {
  // External dependencies are already registered in initDependencies

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl.new);

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: sl<AuthLocalDataSource>(),
      remoteDataSource: sl<AuthRemoteDataSource>(),
    ),
  );

  // Services
  sl.registerLazySingleton<TokenRefreshService>(
    () => TokenRefreshService(
      authRepository: sl<AuthRepository>(),
      dio: sl<Dio>(),
    ),
  );

  // BLoC
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      authRepository: sl<AuthRepository>(),
      tokenRefreshService: sl<TokenRefreshService>(),
    ),
  );

  // Theme BLoC
  sl.registerLazySingleton<ThemeBloc>(ThemeBloc.new);
}
