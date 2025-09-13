import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repositories/auth_repository.dart';
import '../models/auth_tokens.dart';
import '../models/user.dart';
import '../services/token_refresh_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc({
    required AuthRepository authRepository,
    required TokenRefreshService tokenRefreshService,
  }) : _authRepository = authRepository,
       _tokenRefreshService = tokenRefreshService,
       super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthTokenRefreshRequested>(_onAuthTokenRefreshRequested);
    on<AuthTokensUpdated>(_onAuthTokensUpdated);
    on<AuthRefreshFailed>(_onAuthRefreshFailed);

    // Set up token refresh service callbacks
    _tokenRefreshService.onTokensRefreshed = (tokens) {
      add(AuthTokensUpdated(tokens));
    };

    _tokenRefreshService.onRefreshFailed = () {
      add(const AuthRefreshFailed());
    };
  }
  final AuthRepository _authRepository;
  final TokenRefreshService _tokenRefreshService;

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final isLoggedIn = await _authRepository.isLoggedIn();

      if (isLoggedIn) {
        final user = await _authRepository.getStoredUser();
        final tokens = await _authRepository.getStoredTokens();

        if (user != null && tokens != null) {
          // Start proactive token refresh
          await _tokenRefreshService.startProactiveRefresh();

          emit(AuthAuthenticated(user: user, tokens: tokens));
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final tokens = await _authRepository.login(event.email, event.password);
      final user = await _authRepository.getCurrentUser();

      // Start proactive token refresh
      await _tokenRefreshService.startProactiveRefresh();

      emit(AuthAuthenticated(user: user, tokens: tokens));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _authRepository.logout();
      _tokenRefreshService.dispose();
      emit(const AuthUnauthenticated());
    } catch (e) {
      // Even if logout fails, consider user unauthenticated
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onAuthTokenRefreshRequested(
    AuthTokenRefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final newTokens = await _tokenRefreshService.refreshToken();

      if (newTokens != null && state is AuthAuthenticated) {
        final currentState = state as AuthAuthenticated;
        emit(currentState.copyWith(tokens: newTokens));
      }
    } catch (e) {
      emit(AuthError('Token refresh failed: ${e.toString()}'));
    }
  }

  Future<void> _onAuthTokensUpdated(
    AuthTokensUpdated event,
    Emitter<AuthState> emit,
  ) async {
    if (state is AuthAuthenticated) {
      final currentState = state as AuthAuthenticated;
      emit(currentState.copyWith(tokens: event.tokens));
    }
  }

  Future<void> _onAuthRefreshFailed(
    AuthRefreshFailed event,
    Emitter<AuthState> emit,
  ) async {
    // Token refresh failed, user needs to login again
    try {
      await _authRepository.logout();
    } catch (e) {
      // Ignore logout errors
    }

    emit(
      const AuthUnauthenticated(
        message: 'Session expired. Please login again.',
      ),
    );
  }

  @override
  Future<void> close() {
    _tokenRefreshService.dispose();
    return super.close();
  }
}
