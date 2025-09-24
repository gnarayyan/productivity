import 'package:varosa_tech/core/usecases/usecase.dart';
import 'package:varosa_tech/features/auth/domain/repositories/auth_remote_repository.dart';

class LogoutUsecase extends NoParamUseCase<void> {
  final AuthRemoteRepository repository;

  LogoutUsecase(this.repository) : super(repository.logout);
}
