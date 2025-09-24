import 'package:equatable/equatable.dart';

import 'user_entity.dart';

abstract class AuthResponse extends Equatable {
  final User user;
  final String accessToken;
  final String refreshToken;

  const AuthResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  String toString() {
    return 'AuthResponse(user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  List<Object> get props => [user, accessToken, refreshToken];

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'user': user.toJson(),
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      },
    };
  }
}
