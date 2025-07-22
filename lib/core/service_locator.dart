import 'package:get_it/get_it.dart';

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

// Mini Ecommerce DI
import '../apps/mini_ecommerce/di/ecommerce_di.dart';

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

  // Mini Ecommerce App Dependencies
  EcommerceDI.register(sl);
}
