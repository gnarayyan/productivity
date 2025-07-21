import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varosa_tech/apps/offline_todo/presentation/bloc/todo_bloc.dart';
import 'package:varosa_tech/core/service_locator.dart';
import 'package:varosa_tech/themes/app_theme.dart';

import 'router/app_router.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (_) => sl<TodoBloc>()..add(LoadTodos()),
      child: MaterialApp.router(
        title: 'Varosa Tech - Evaluation Apps',
        theme: AppTheme.lightTheme,
        routerConfig: _appRouter.config(),

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
