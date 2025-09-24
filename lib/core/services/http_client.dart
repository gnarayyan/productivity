import 'package:fpdart/fpdart.dart';
import 'package:varosa_tech/core/error/exceptions.dart';
import 'package:varosa_tech/core/services/api_service.dart';

mixin HttpClient {
  late final ApiService apiService;
  late final String path;

  void init(ApiService apiService) {
    this.apiService = apiService;
  }

  Future<Either<CustomException, List<T>>> fetchAll<T>({
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    final response = await apiService.get(path);

    return response.fold(Left.new, (response) {
      final List<dynamic> data = response.data;
      final List<T> result = data.map((json) => fromMap(json)).toList();
      return Right(result);
    });
  }

  Future<Either<CustomException, T>> fetch<T>({
    required String id,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    final response = await apiService.get('/$path/$id');

    return response.fold(Left.new, (response) {
      final T result = fromMap(response.data);
      return Right(result);
    });
  }

  Future<Either<CustomException, T>> save<T>({
    required T Function(Map<String, dynamic>) fromMap,
    required Map<String, dynamic> data,
  }) async {
    final response = await apiService.post('/$path', data: data);

    return response.fold(Left.new, (response) {
      final T result = fromMap(response.data);
      return Right(result);
    });
  }

  /// Update
  Future<Either<CustomException, T>> modify<T>({
    required String id,
    required T Function(Map<String, dynamic>) fromMap,
    required Map<String, dynamic> data,
  }) async {
    final response = await apiService.put('/$path/$id', data: data);

    return response.fold(Left.new, (response) {
      final T result = fromMap(response.data);
      return Right(result);
    });
  }

  /// Delete
  Future<Either<CustomException, T>> remove<T>({
    required String id,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    final response = await apiService.delete('/$path/$id');

    return response.fold(Left.new, (response) {
      final T result = fromMap(response.data);
      return Right(result);
    });
  }
}

mixin HttpClientWithSeperateUrl {
  late final ApiService apiService;

  Future<Either<CustomException, List<T>>> getAll<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    final response = await apiService.get(path);

    return response.fold(Left.new, (response) {
      final List<dynamic> data = response.data;
      final List<T> result = data.map((json) => fromMap(json)).toList();
      return Right(result);
    });
  }

  Future<Either<CustomException, T>> get<T>({
    required String path,
    required String id,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    final response = await apiService.get('/$path/$id');

    return response.fold(Left.new, (response) {
      final T result = fromMap(response.data);
      return Right(result);
    });
  }

  Future<Either<CustomException, T>> post<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromMap,
    Map<String, dynamic>? data,
  }) async {
    final response = await apiService.post('/$path', data: data);

    return response.fold(Left.new, (response) {
      final T result = fromMap(response.data);
      return Right(result);
    });
  }

  /// Update
  Future<Either<CustomException, T>> put<T>({
    required String path,
    required String id,
    required T Function(Map<String, dynamic>) fromMap,
    required Map<String, dynamic> data,
  }) async {
    final response = await apiService.put('/$path/$id', data: data);

    return response.fold(Left.new, (response) {
      final T result = fromMap(response.data);
      return Right(result);
    });
  }

  /// Delete
  Future<Either<CustomException, T>> delete<T>({
    required String path,
    required String id,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    final response = await apiService.delete('/$path/$id');

    return response.fold(Left.new, (response) {
      final T result = fromMap(response.data);
      return Right(result);
    });
  }
}
