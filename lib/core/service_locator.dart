import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Productivity app imports
import '../presentation/bloc/productivity_navigation_bloc.dart';
// Theme imports
import '../themes/bloc/theme_bloc.dart';
import 'auth/bloc/auth_bloc.dart';
// Auth imports
import 'auth/data/datasources/auth_local_data_source.dart';
import 'auth/data/datasources/auth_remote_data_source.dart';
import 'auth/data/repositories/auth_repository_impl.dart';
import 'auth/domain/repositories/auth_repository.dart';
import 'auth/services/token_refresh_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  // sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);


  // Productivity App Dependencies
  sl.registerFactory(ProductivityNavigationBloc.new);



  // Auth App Dependencies
  await _setupAuthDependencies();
}

Future<void> _setupAuthDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // final dio = Dio();
  // sl.registerSingleton<Dio>(dio);

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
