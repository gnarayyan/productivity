// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:varosa_tech/apps/dynamic_form/presentation/pages/dynamic_form_page.dart'
    as _i3;
import 'package:varosa_tech/apps/method_channel/view/pages/method_channel_page.dart'
    as _i7;
import 'package:varosa_tech/apps/mini_ecommerce/features/products/presentation/pages/ecommerce_page.dart'
    as _i4;
import 'package:varosa_tech/apps/nested_bottom_nav/pages/nested_bottom_nav_page.dart'
    as _i8;
import 'package:varosa_tech/apps/offline_todo/domain/entities/todo.dart'
    as _i13;
import 'package:varosa_tech/apps/offline_todo/presentation/pages/add_todo_page.dart'
    as _i1;
import 'package:varosa_tech/apps/offline_todo/presentation/pages/edit_todo_page.dart'
    as _i5;
import 'package:varosa_tech/apps/offline_todo/presentation/pages/todo_page.dart'
    as _i10;
import 'package:varosa_tech/apps/productivity/presentation/pages/productivity_main_page.dart'
    as _i9;
import 'package:varosa_tech/core/auth/pages/auth_demo_page.dart' as _i2;
import 'package:varosa_tech/core/landing_page/landing_page.dart' as _i6;

/// generated route for
/// [_i1.AddTodoPage]
class AddTodoRoute extends _i11.PageRouteInfo<void> {
  const AddTodoRoute({List<_i11.PageRouteInfo>? children})
    : super(AddTodoRoute.name, initialChildren: children);

  static const String name = 'AddTodoRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddTodoPage();
    },
  );
}

/// generated route for
/// [_i2.AuthDemoPage]
class AuthDemoRoute extends _i11.PageRouteInfo<void> {
  const AuthDemoRoute({List<_i11.PageRouteInfo>? children})
    : super(AuthDemoRoute.name, initialChildren: children);

  static const String name = 'AuthDemoRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthDemoPage();
    },
  );
}

/// generated route for
/// [_i3.DynamicFormPage]
class DynamicFormRoute extends _i11.PageRouteInfo<void> {
  const DynamicFormRoute({List<_i11.PageRouteInfo>? children})
    : super(DynamicFormRoute.name, initialChildren: children);

  static const String name = 'DynamicFormRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.DynamicFormPage();
    },
  );
}

/// generated route for
/// [_i4.EcommercePage]
class EcommerceRoute extends _i11.PageRouteInfo<void> {
  const EcommerceRoute({List<_i11.PageRouteInfo>? children})
    : super(EcommerceRoute.name, initialChildren: children);

  static const String name = 'EcommerceRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.EcommercePage();
    },
  );
}

/// generated route for
/// [_i5.EditTodoPage]
class EditTodoRoute extends _i11.PageRouteInfo<EditTodoRouteArgs> {
  EditTodoRoute({
    _i12.Key? key,
    required _i13.Todo todo,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         EditTodoRoute.name,
         args: EditTodoRouteArgs(key: key, todo: todo),
         initialChildren: children,
       );

  static const String name = 'EditTodoRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditTodoRouteArgs>();
      return _i5.EditTodoPage(key: args.key, todo: args.todo);
    },
  );
}

class EditTodoRouteArgs {
  const EditTodoRouteArgs({this.key, required this.todo});

  final _i12.Key? key;

  final _i13.Todo todo;

  @override
  String toString() {
    return 'EditTodoRouteArgs{key: $key, todo: $todo}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditTodoRouteArgs) return false;
    return key == other.key && todo == other.todo;
  }

  @override
  int get hashCode => key.hashCode ^ todo.hashCode;
}

/// generated route for
/// [_i6.LandingPage]
class LandingRoute extends _i11.PageRouteInfo<void> {
  const LandingRoute({List<_i11.PageRouteInfo>? children})
    : super(LandingRoute.name, initialChildren: children);

  static const String name = 'LandingRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.LandingPage();
    },
  );
}

/// generated route for
/// [_i7.MethodChannelPage]
class MethodChannelRoute extends _i11.PageRouteInfo<void> {
  const MethodChannelRoute({List<_i11.PageRouteInfo>? children})
    : super(MethodChannelRoute.name, initialChildren: children);

  static const String name = 'MethodChannelRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.MethodChannelPage();
    },
  );
}

/// generated route for
/// [_i8.NestedBottomNavPage]
class NestedBottomNavRoute extends _i11.PageRouteInfo<void> {
  const NestedBottomNavRoute({List<_i11.PageRouteInfo>? children})
    : super(NestedBottomNavRoute.name, initialChildren: children);

  static const String name = 'NestedBottomNavRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.NestedBottomNavPage();
    },
  );
}

/// generated route for
/// [_i9.ProductivityMainPage]
class ProductivityMainRoute extends _i11.PageRouteInfo<void> {
  const ProductivityMainRoute({List<_i11.PageRouteInfo>? children})
    : super(ProductivityMainRoute.name, initialChildren: children);

  static const String name = 'ProductivityMainRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.ProductivityMainPage();
    },
  );
}

/// generated route for
/// [_i10.TodoPage]
class TodoRoute extends _i11.PageRouteInfo<void> {
  const TodoRoute({List<_i11.PageRouteInfo>? children})
    : super(TodoRoute.name, initialChildren: children);

  static const String name = 'TodoRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.TodoPage();
    },
  );
}
