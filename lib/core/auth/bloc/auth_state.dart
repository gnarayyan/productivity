part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final AuthTokens tokens;

  const AuthAuthenticated({required this.user, required this.tokens});

  AuthAuthenticated copyWith({User? user, AuthTokens? tokens}) {
    return AuthAuthenticated(
      user: user ?? this.user,
      tokens: tokens ?? this.tokens,
    );
  }

  @override
  List<Object?> get props => [user, tokens];
}

class AuthUnauthenticated extends AuthState {
  final String? message;

  const AuthUnauthenticated({this.message});

  @override
  List<Object?> get props => [message];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
