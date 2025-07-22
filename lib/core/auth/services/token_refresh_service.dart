import 'dart:async';
import 'package:dio/dio.dart';
import '../domain/repositories/auth_repository.dart';
import '../models/auth_tokens.dart';

/// Service responsible for automatically handling token refresh
/// This service acts as an interceptor and automatic token manager
class TokenRefreshService {
  final AuthRepository _authRepository;
  final Dio _dio;

  // Track ongoing refresh operations to prevent multiple simultaneous refreshes
  Completer<AuthTokens>? _refreshCompleter;

  // Timer for proactive token refresh
  Timer? _refreshTimer;

  // Callback for when tokens are refreshed
  void Function(AuthTokens tokens)? onTokensRefreshed;

  // Callback for when refresh fails (logout scenario)
  void Function()? onRefreshFailed;

  TokenRefreshService({
    required AuthRepository authRepository,
    required Dio dio,
    this.onTokensRefreshed,
    this.onRefreshFailed,
  }) : _authRepository = authRepository,
       _dio = dio {
    _setupDioInterceptor();
  }

  /// Set up Dio interceptor to automatically handle 401 responses
  void _setupDioInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add authorization header if we have valid tokens
          final tokens = await _authRepository.getStoredTokens();
          if (tokens != null && !tokens.isExpired) {
            options.headers['Authorization'] =
                '${tokens.tokenType} ${tokens.accessToken}';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          // Handle 401 Unauthorized responses
          if (error.response?.statusCode == 401) {
            try {
              // Attempt to refresh token
              final newTokens = await _refreshTokenSafely();

              if (newTokens != null) {
                // Retry the original request with new token
                final requestOptions = error.requestOptions;
                requestOptions.headers['Authorization'] =
                    '${newTokens.tokenType} ${newTokens.accessToken}';

                final response = await _dio.fetch(requestOptions);
                handler.resolve(response);
                return;
              }
            } catch (e) {
              // Refresh failed, let the error pass through
            }
          }

          handler.next(error);
        },
      ),
    );
  }

  /// Start proactive token refresh based on token expiration
  Future<void> startProactiveRefresh() async {
    _stopProactiveRefresh();

    final tokens = await _authRepository.getStoredTokens();
    if (tokens == null) return;

    _scheduleNextRefresh(tokens);
  }

  /// Stop proactive token refresh
  void _stopProactiveRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  /// Schedule the next token refresh based on token expiration
  void _scheduleNextRefresh(AuthTokens tokens) {
    _stopProactiveRefresh();

    // Calculate when to refresh (5 minutes before expiration)
    final refreshTime = tokens.expiresAt.subtract(const Duration(minutes: 5));
    final now = DateTime.now();

    if (refreshTime.isAfter(now)) {
      final delay = refreshTime.difference(now);
      _refreshTimer = Timer(delay, () async {
        try {
          await _refreshTokenSafely();
        } catch (e) {
          // If proactive refresh fails, we'll rely on reactive refresh
        }
      });
    } else {
      // Token is already close to expiration, refresh immediately
      Future.microtask(() async {
        try {
          await _refreshTokenSafely();
        } catch (e) {
          // Handle refresh failure
        }
      });
    }
  }

  /// Safely refresh token with concurrency control
  Future<AuthTokens?> _refreshTokenSafely() async {
    // If a refresh is already in progress, wait for it
    if (_refreshCompleter != null) {
      try {
        return await _refreshCompleter!.future;
      } catch (e) {
        return null;
      }
    }

    // Start new refresh operation
    _refreshCompleter = Completer<AuthTokens>();

    try {
      final currentTokens = await _authRepository.getStoredTokens();
      if (currentTokens == null) {
        throw Exception('No tokens available for refresh');
      }

      // Perform the actual refresh
      final newTokens = await _authRepository.refreshToken(
        currentTokens.refreshToken,
      );

      // Schedule next proactive refresh
      _scheduleNextRefresh(newTokens);

      // Notify listeners
      onTokensRefreshed?.call(newTokens);

      // Complete the refresh operation
      _refreshCompleter!.complete(newTokens);
      return newTokens;
    } catch (e) {
      // Refresh failed
      onRefreshFailed?.call();
      _refreshCompleter!.completeError(e);
      throw e;
    } finally {
      _refreshCompleter = null;
    }
  }

  /// Manually trigger token refresh
  Future<AuthTokens?> refreshToken() async {
    try {
      return await _refreshTokenSafely();
    } catch (e) {
      return null;
    }
  }

  /// Check if current tokens need refresh
  Future<bool> shouldRefreshToken() async {
    final tokens = await _authRepository.getStoredTokens();
    return tokens?.willExpireSoon ?? false;
  }

  /// Get current valid tokens, refreshing if necessary
  Future<AuthTokens?> getValidTokens() async {
    final tokens = await _authRepository.getStoredTokens();

    if (tokens == null) return null;

    if (tokens.willExpireSoon) {
      try {
        return await _refreshTokenSafely();
      } catch (e) {
        return null;
      }
    }

    return tokens;
  }

  /// Clean up resources
  void dispose() {
    _stopProactiveRefresh();
    _refreshCompleter = null;
  }
}
