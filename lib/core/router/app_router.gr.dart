// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:varosa_tech/apps/dynamic_form/presentation/pages/dynamic_form_page.dart'
    as _i2;
import 'package:varosa_tech/apps/method_channel/view/pages/method_channel_page.dart'
    as _i5;
import 'package:varosa_tech/apps/offline_todo/domain/entities/todo.dart' as _i9;
import 'package:varosa_tech/apps/offline_todo/presentation/pages/add_todo_page.dart'
    as _i1;
import 'package:varosa_tech/apps/offline_todo/presentation/pages/edit_todo_page.dart'
    as _i3;
import 'package:varosa_tech/apps/offline_todo/presentation/pages/todo_page.dart'
    as _i6;
import 'package:varosa_tech/core/landing_page/landing_page.dart' as _i4;

/// generated route for
/// [_i1.AddTodoPage]
class AddTodoRoute extends _i7.PageRouteInfo<void> {
  const AddTodoRoute({List<_i7.PageRouteInfo>? children})
    : super(AddTodoRoute.name, initialChildren: children);

  static const String name = 'AddTodoRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddTodoPage();
    },
  );
}

/// generated route for
/// [_i2.DynamicFormPage]
class DynamicFormRoute extends _i7.PageRouteInfo<void> {
  const DynamicFormRoute({List<_i7.PageRouteInfo>? children})
    : super(DynamicFormRoute.name, initialChildren: children);

  static const String name = 'DynamicFormRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.DynamicFormPage();
    },
  );
}

/// generated route for
/// [_i3.EditTodoPage]
class EditTodoRoute extends _i7.PageRouteInfo<EditTodoRouteArgs> {
  EditTodoRoute({
    _i8.Key? key,
    required _i9.Todo todo,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         EditTodoRoute.name,
         args: EditTodoRouteArgs(key: key, todo: todo),
         initialChildren: children,
       );

  static const String name = 'EditTodoRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditTodoRouteArgs>();
      return _i3.EditTodoPage(key: args.key, todo: args.todo);
    },
  );
}

class EditTodoRouteArgs {
  const EditTodoRouteArgs({this.key, required this.todo});

  final _i8.Key? key;

  final _i9.Todo todo;

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
/// [_i4.LandingPage]
class LandingRoute extends _i7.PageRouteInfo<void> {
  const LandingRoute({List<_i7.PageRouteInfo>? children})
    : super(LandingRoute.name, initialChildren: children);

  static const String name = 'LandingRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.LandingPage();
    },
  );
}

/// generated route for
/// [_i5.MethodChannelPage]
class MethodChannelRoute extends _i7.PageRouteInfo<void> {
  const MethodChannelRoute({List<_i7.PageRouteInfo>? children})
    : super(MethodChannelRoute.name, initialChildren: children);

  static const String name = 'MethodChannelRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.MethodChannelPage();
    },
  );
}

/// generated route for
/// [_i6.TodoPage]
class TodoRoute extends _i7.PageRouteInfo<void> {
  const TodoRoute({List<_i7.PageRouteInfo>? children})
    : super(TodoRoute.name, initialChildren: children);

  static const String name = 'TodoRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.TodoPage();
    },
  );
}
