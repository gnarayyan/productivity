// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:varosa_tech/core/auth/pages/auth_demo_page.dart' as _i2;
import 'package:varosa_tech/features/auth/presentation/screens/login_page.dart'
    as _i3;
import 'package:varosa_tech/features/auth/presentation/screens/signup_page.dart'
    as _i7;
import 'package:varosa_tech/features/personal_productivity/shared/presentation/pages/personal_productivity_page.dart'
    as _i5;
import 'package:varosa_tech/features/shared/presentation/pages/app_update_page.dart'
    as _i1;
import 'package:varosa_tech/features/shared/presentation/pages/no_internet_page.dart'
    as _i4;
import 'package:varosa_tech/features/shared/presentation/pages/server_maintenance_page.dart'
    as _i6;
import 'package:varosa_tech/features/splash/presentation/pages/splash_page.dart'
    as _i8;

/// generated route for
/// [_i1.AppUpdatePage]
class AppUpdateRoute extends _i9.PageRouteInfo<AppUpdateRouteArgs> {
  AppUpdateRoute({
    _i10.Key? key,
    required String currentVersion,
    required String requiredVersion,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         AppUpdateRoute.name,
         args: AppUpdateRouteArgs(
           key: key,
           currentVersion: currentVersion,
           requiredVersion: requiredVersion,
         ),
         initialChildren: children,
       );

  static const String name = 'AppUpdateRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppUpdateRouteArgs>();
      return _i1.AppUpdatePage(
        key: args.key,
        currentVersion: args.currentVersion,
        requiredVersion: args.requiredVersion,
      );
    },
  );
}

class AppUpdateRouteArgs {
  const AppUpdateRouteArgs({
    this.key,
    required this.currentVersion,
    required this.requiredVersion,
  });

  final _i10.Key? key;

  final String currentVersion;

  final String requiredVersion;

  @override
  String toString() {
    return 'AppUpdateRouteArgs{key: $key, currentVersion: $currentVersion, requiredVersion: $requiredVersion}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppUpdateRouteArgs) return false;
    return key == other.key &&
        currentVersion == other.currentVersion &&
        requiredVersion == other.requiredVersion;
  }

  @override
  int get hashCode =>
      key.hashCode ^ currentVersion.hashCode ^ requiredVersion.hashCode;
}

/// generated route for
/// [_i2.AuthDemoPage]
class AuthDemoRoute extends _i9.PageRouteInfo<void> {
  const AuthDemoRoute({List<_i9.PageRouteInfo>? children})
    : super(AuthDemoRoute.name, initialChildren: children);

  static const String name = 'AuthDemoRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthDemoPage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginPage();
    },
  );
}

/// generated route for
/// [_i4.NoInternetPage]
class NoInternetRoute extends _i9.PageRouteInfo<void> {
  const NoInternetRoute({List<_i9.PageRouteInfo>? children})
    : super(NoInternetRoute.name, initialChildren: children);

  static const String name = 'NoInternetRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.NoInternetPage();
    },
  );
}

/// generated route for
/// [_i5.PersonalProductivityPage]
class PersonalProductivityRoute extends _i9.PageRouteInfo<void> {
  const PersonalProductivityRoute({List<_i9.PageRouteInfo>? children})
    : super(PersonalProductivityRoute.name, initialChildren: children);

  static const String name = 'PersonalProductivityRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.PersonalProductivityPage();
    },
  );
}

/// generated route for
/// [_i6.ServerMaintenancePage]
class ServerMaintenanceRoute
    extends _i9.PageRouteInfo<ServerMaintenanceRouteArgs> {
  ServerMaintenanceRoute({
    _i10.Key? key,
    required String message,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         ServerMaintenanceRoute.name,
         args: ServerMaintenanceRouteArgs(key: key, message: message),
         initialChildren: children,
       );

  static const String name = 'ServerMaintenanceRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServerMaintenanceRouteArgs>();
      return _i6.ServerMaintenancePage(key: args.key, message: args.message);
    },
  );
}

class ServerMaintenanceRouteArgs {
  const ServerMaintenanceRouteArgs({this.key, required this.message});

  final _i10.Key? key;

  final String message;

  @override
  String toString() {
    return 'ServerMaintenanceRouteArgs{key: $key, message: $message}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ServerMaintenanceRouteArgs) return false;
    return key == other.key && message == other.message;
  }

  @override
  int get hashCode => key.hashCode ^ message.hashCode;
}

/// generated route for
/// [_i7.SignupPage]
class SignupRoute extends _i9.PageRouteInfo<void> {
  const SignupRoute({List<_i9.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SignupPage();
    },
  );
}

/// generated route for
/// [_i8.SplashPage]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.SplashPage();
    },
  );
}
