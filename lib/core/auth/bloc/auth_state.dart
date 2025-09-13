part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {

  const AuthAuthenticated({required this.user, required this.tokens});
  final User user;
  final AuthTokens tokens;

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

  const AuthUnauthenticated({this.message});
  final String? message;

  @override
  List<Object?> get props => [message];
}

class AuthError extends AuthState {

  const AuthError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
