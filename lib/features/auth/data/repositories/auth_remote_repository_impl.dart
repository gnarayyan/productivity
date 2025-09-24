import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:varosa_tech/core/constants/api_constants.dart';
import 'package:varosa_tech/core/domain/remote_repository.dart';
import 'package:varosa_tech/core/error/exceptions.dart';
import 'package:varosa_tech/core/services/api_service.dart';
import 'package:varosa_tech/core/services/http_client.dart';
import 'package:varosa_tech/features/auth/data/models/auth_response_model.dart';
import 'package:varosa_tech/features/auth/data/models/user_model.dart';
import 'package:varosa_tech/features/auth/domain/entities/login_request_entity.dart';
import 'package:varosa_tech/features/auth/domain/entities/signup_request_entity.dart';
import 'package:varosa_tech/features/auth/domain/repositories/auth_remote_repository.dart';

// @LazySingleton(as: AuthRepository) 
@LazySingleton(as: AuthRemoteRepository)
class AuthRemoteRepositoryImpl
    with HttpClientWithSeperateUrl
    implements AuthRemoteRepository {
  final ApiService _apiService;

  AuthRemoteRepositoryImpl(this._apiService) {
    // Initialize the mixin data
    apiService = _apiService;
  }

  @override
  RepositoryResult<AuthResponseModel> login(LoginRequest request) =>
      post<AuthResponseModel>(
        path: ApiConstants.login,
        data: request.toJson(),
        fromMap: AuthResponseModel.fromMap,
      );

  @override
  RepositoryResult<AuthResponseModel> signup(SignupRequest request) => post(
    path: ApiConstants.signup,
    data: request.toJson(),
    fromMap: AuthResponseModel.fromMap,
  );

  @override
  RepositoryResult<void> logout() =>
      post(path: ApiConstants.logout, fromMap: AuthResponseModel.fromMap);

  @override
  RepositoryResult<AuthResponseModel> refreshToken(String refreshToken) =>
      post(path: ApiConstants.refreshToken, fromMap: AuthResponseModel.fromMap);

  // final accessToken = await _authLocalRepository.getAccessToken();
  // if (accessToken == null) {
  //   return const Left(AuthenticationException('No access token found'));
  // }
  @override
  Future<Either<CustomException, UserModel>> getCurrentUser(
    String accessToken,
  ) => post(path: ApiConstants.profile, fromMap: UserModel.fromJson);
}
