import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/service_locator.dart';
import '../../../themes/app_theme.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/login_form.dart';
import '../widgets/authenticated_dashboard.dart';

@RoutePage()
class AuthDemoPage extends StatelessWidget {
  const AuthDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(const AuthCheckRequested()),
      child: const AuthDemoView(),
    );
  }
}

class AuthDemoView extends StatelessWidget {
  const AuthDemoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Refresh Token Demo',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }

          if (state is AuthUnauthenticated && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
                backgroundColor: AppColors.warning,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is AuthAuthenticated) {
            return AuthenticatedDashboard(
              user: state.user,
              tokens: state.tokens,
            );
          }

          return const LoginForm();
        },
      ),
    );
  }
}
