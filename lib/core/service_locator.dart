import 'package:get_it/get_it.dart';

import '../apps/offline_todo/data/datasources/local_datasource.dart';
import '../apps/offline_todo/data/repositories/todo_repository_impl.dart';
import '../apps/offline_todo/domain/repositories/todo_repository.dart';
import '../apps/offline_todo/domain/usecases/todo_usecases.dart';
import '../apps/offline_todo/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

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

  // Bloc
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
}
