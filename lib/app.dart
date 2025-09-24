import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varosa_tech/core/router/app_router.dart';
import 'package:varosa_tech/core/service_locator.dart';
import 'package:varosa_tech/core/themes/app_theme.dart';
import 'package:varosa_tech/core/themes/bloc/theme_bloc.dart';
import 'package:varosa_tech/core/themes/bloc/theme_state.dart';

final _appRouter = AppRouter();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<ThemeBloc>(create: (_) => sl<ThemeBloc>())],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'Productivity',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: _appRouter.config(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
