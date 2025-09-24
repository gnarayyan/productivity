class ApiConstants {
  // Base URL
  static const String baseUrl = 'http://192.168.1.121:3000/api/v1';

  // Authentication endpoints
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Goals endpoints
  static const String goals = '/goals';

  // User endpoints
  static const String users = '/users';
  static const String profile = '/users/profile';

  // Headers
  static const String contentTypeJson = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer ';

  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
}
