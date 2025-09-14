// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:varosa_tech/apps/productivity/presentation/pages/productivity_main_page.dart'
    as _i2;
import 'package:varosa_tech/core/auth/pages/auth_demo_page.dart' as _i1;

/// generated route for
/// [_i1.AuthDemoPage]
class AuthDemoRoute extends _i3.PageRouteInfo<void> {
  const AuthDemoRoute({List<_i3.PageRouteInfo>? children})
    : super(AuthDemoRoute.name, initialChildren: children);

  static const String name = 'AuthDemoRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthDemoPage();
    },
  );
}

/// generated route for
/// [_i2.ProductivityMainPage]
class ProductivityMainRoute extends _i3.PageRouteInfo<void> {
  const ProductivityMainRoute({List<_i3.PageRouteInfo>? children})
    : super(ProductivityMainRoute.name, initialChildren: children);

  static const String name = 'ProductivityMainRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.ProductivityMainPage();
    },
  );
}
