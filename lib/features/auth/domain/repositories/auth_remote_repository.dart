import 'package:fpdart/fpdart.dart';
import 'package:varosa_tech/core/domain/remote_repository.dart';
import 'package:varosa_tech/core/error/exceptions.dart';
import 'package:varosa_tech/features/auth/domain/entities/auth_response_entity.dart';
import 'package:varosa_tech/features/auth/domain/entities/login_request_entity.dart';
import 'package:varosa_tech/features/auth/domain/entities/signup_request_entity.dart';
import 'package:varosa_tech/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteRepository {
  RepositoryResult<AuthResponse> login(LoginRequest request);
  Future<Either<CustomException, AuthResponse>> signup(SignupRequest request);
  Future<Either<CustomException, void>> logout();
  Future<Either<CustomException, AuthResponse>> refreshToken(
    String refreshToken,
  );
  Future<Either<CustomException, User>> getCurrentUser(String accessToken);
}
