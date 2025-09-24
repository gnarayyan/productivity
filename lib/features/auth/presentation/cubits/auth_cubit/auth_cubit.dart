import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:varosa_tech/features/auth/domain/entities/login_request_entity.dart';
import 'package:varosa_tech/features/auth/domain/entities/signup_request_entity.dart';
import 'package:varosa_tech/features/auth/domain/entities/user_entity.dart';
import 'package:varosa_tech/features/auth/domain/repositories/auth_local_repository.dart';
import 'package:varosa_tech/features/auth/domain/repositories/auth_remote_repository.dart';

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

// Cubit
@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteRepository _authRepository;
  final AuthLocalRepository _authLocalRepository;

  AuthCubit(this._authRepository, this._authLocalRepository)
    : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    final isLoggedIn = await _authLocalRepository.isLoggedIn();
    if (isLoggedIn) {
      final user = await _authLocalRepository.getCachedUser();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    final request = LoginRequest(email: email, password: password);
    final result = await _authRepository.login(request);

    result.fold((exception) => emit(AuthError(message: exception.message)), (
      authResponse,
    ) {
      emit(AuthAuthenticated(user: authResponse.user));
      _authLocalRepository.saveAuthData(authResponse); // Save auth data locally
    });
  }

  Future<void> signup(String name, String email, String password) async {
    emit(AuthLoading());

    final request = SignupRequest(name: name, email: email, password: password);
    final result = await _authRepository.signup(request);

    result.fold((exception) => emit(AuthError(message: exception.message)), (
      authResponse,
    ) {
      emit(AuthAuthenticated(user: authResponse.user));
      _authLocalRepository.saveAuthData(authResponse); // Save auth data locally
    });
  }

  Future<void> logout() async {
    emit(AuthLoading());

    final result = await _authRepository.logout();

    result.fold(
      (exception) => emit(AuthError(message: exception.toString())),
      (_) => emit(AuthUnauthenticated()),
    );

    // Even if server logout fails (or succeds), clear local data
    await _authLocalRepository.clearAuthData();
  }

  Future<void> refreshToken() async {
    final refreshToken = await _authLocalRepository.getRefreshToken();
    if (refreshToken != null) {
      final result = await _authRepository.refreshToken(refreshToken);

      result.fold((exception) {
        // If refresh fails, logout user
        logout();
      }, (authResponse) => emit(AuthAuthenticated(user: authResponse.user)));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
