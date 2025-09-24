import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varosa_tech/core/di/injection.dart';
import 'package:varosa_tech/core/router/app_router.gr.dart';
import 'package:varosa_tech/features/shared/presentation/pages/app_update_page.dart';
import 'package:varosa_tech/features/shared/presentation/pages/no_internet_page.dart';
import 'package:varosa_tech/features/shared/presentation/pages/server_maintenance_page.dart';
import 'package:varosa_tech/features/splash/presentation/bloc/app_init_bloc.dart';
import 'package:varosa_tech/features/splash/presentation/widgets/splash_widget.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppInitBloc>(
      create: (context) =>
          getIt<AppInitBloc>()..add(const AppInitEvent.started()),
      child: BlocConsumer<AppInitBloc, AppInitState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (isFirstTimeUser, isAuthenticated) {
              // Navigate based on auth/onboarding status
              if (isFirstTimeUser) {
                Navigator.pushReplacementNamed(context, '/onboarding');
              } else if (isAuthenticated) {
             context.pushRoute(const PersonalProductivityRoute());
              } else {
                context.pushRoute(const LoginRoute());
              }
            },
            noInternet: () => context.pushRoute(const NoInternetRoute()),
          );
        },
        builder: (context, state) {
          return Scaffold(
            body: state.when(
              initial: () => const SplashWidget(),
              loading: () => const SplashWidget(),
              noInternet: NoInternetPage.new,
              appUpdateRequired: (current, required) => AppUpdatePage(
                currentVersion: current,
                requiredVersion: required,
              ),
              maintenanceMode: (message) =>
                  ServerMaintenancePage(message: message),
              success: (_, __) => const SizedBox.shrink(),
              error: (message) => Center(child: Text('Error: $message')),
            ),
          );
        },
      ),
    );
  }
}
