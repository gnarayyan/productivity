import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apps/method_channel/bloc/device_info_bloc.dart';
import '../apps/method_channel/services/device_info_service.dart';
import '../apps/offline_todo/data/datasources/local_datasource.dart';
import '../apps/offline_todo/data/repositories/todo_repository_impl.dart';
import '../apps/offline_todo/domain/repositories/todo_repository.dart';
import '../apps/offline_todo/domain/usecases/todo_usecases.dart';
import '../apps/offline_todo/presentation/bloc/todo_bloc.dart';

// Dynamic Form imports
import '../apps/dynamic_form/models/form_data_source.dart';
import '../apps/dynamic_form/bloc/dynamic_form_bloc.dart';

// Nested Bottom Nav imports
import '../apps/nested_bottom_nav/bloc/navigation_bloc.dart';

// Productivity app imports
import '../apps/productivity/presentation/bloc/productivity_navigation_bloc.dart';

// Theme imports
import '../themes/bloc/theme_bloc.dart';

// Mini Ecommerce DI
import '../apps/mini_ecommerce/di/ecommerce_di.dart';

// Auth imports
import 'auth/data/datasources/auth_local_data_source.dart';
import 'auth/data/datasources/auth_remote_data_source.dart';
import 'auth/data/repositories/auth_repository_impl.dart';
import 'auth/domain/repositories/auth_repository.dart';
import 'auth/services/token_refresh_service.dart';
import 'auth/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  // Todo App Dependencies
  // Repository - Register the interface, not the implementation
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton<GetAllTodos>(() => GetAllTodos(sl()));
  sl.registerLazySingleton<AddTodo>(() => AddTodo(sl()));
  sl.registerLazySingleton<UpdateTodo>(() => UpdateTodo(sl()));
  sl.registerLazySingleton<DeleteTodo>(() => DeleteTodo(sl()));
  sl.registerLazySingleton<ToggleTodoStatus>(() => ToggleTodoStatus(sl()));
  sl.registerLazySingleton<SearchTodos>(() => SearchTodos(sl()));
  sl.registerLazySingleton<GetTodosByStatus>(() => GetTodosByStatus(sl()));

  // Todo Bloc
  sl.registerFactory(
    () => TodoBloc(
      getAllTodos: sl(),
      addTodo: sl(),
      updateTodo: sl(),
      deleteTodo: sl(),
      toggleTodoStatus: sl(),
      searchTodos: sl(),
      getTodosByStatus: sl(),
    ),
  );

  // Method Channel App Dependencies
  // Services
  sl.registerLazySingleton<DeviceInfoService>(() => DeviceInfoService());

  // Bloc
  sl.registerFactory(() => DeviceInfoBloc(sl()));

  // Dynamic Form App Dependencies
  // Data sources
  sl.registerLazySingleton<FormDataSource>(() => FormDataSource());

  // Bloc
  sl.registerFactory(() => DynamicFormBloc(sl()));

  // Nested Bottom Nav App Dependencies
  sl.registerFactory(() => NavigationBloc());

  // Productivity App Dependencies
  sl.registerFactory(() => ProductivityNavigationBloc());

  // Mini Ecommerce App Dependencies
  EcommerceDI.register(sl);

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
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

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
  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
}
