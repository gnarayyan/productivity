// import 'package:fpdart/fpdart.dart';
// import 'package:varosa_tech/core/data/datasource/remote_datasource.dart';
// import 'package:varosa_tech/core/error/exceptions.dart';
// import 'package:varosa_tech/core/services/api_service.dart';
// import 'package:varosa_tech/core/services/http_client.dart';
// import 'package:varosa_tech/features/auth/data/models/auth_model.dart';

// class AuthRemoteDataSourceImpl
//     with HttpClient<AuthModel>
//     implements RemoteDataSource<AuthModel> {
//   @override
//   final ApiService apiService;
//   AuthRemoteDataSourceImpl(this.apiService);

//   @override
//   final String path = '/auths';

//   @override
//   Future<Either<CustomException, List<AuthModel>>> getAll() =>
//       fetchAll(fromMap: AuthModel.fromMap);

//   @override
//   Future<Either<CustomException, AuthModel>> get(String id) =>
//       fetch(id: id, fromMap: AuthModel.fromMap);

//   @override
//   Future<Either<CustomException, AuthModel>> create(AuthModel auth) =>
//       save(fromMap: AuthModel.fromMap, data: auth.toMap());

//   @override
//   Future<Either<CustomException, AuthModel>> update(AuthModel auth) =>
//       modify(id: auth.id, fromMap: AuthModel.fromMap, data: auth.toMap());

//   @override
//   Future<Either<CustomException, AuthModel>> delete(String id) =>
//       remove(id: id, fromMap: AuthModel.fromMap);
// }
