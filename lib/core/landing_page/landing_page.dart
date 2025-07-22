import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:varosa_tech/core/landing_page/app_card.dart';
import '../../../themes/app_theme.dart';
import '../router/app_router.gr.dart';

@RoutePage()
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Header
              Text(
                'Varosa Tech',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Evaluation Apps Collection',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),

              // Apps Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.1,
                  children: [
                    AppCard(
                      title: 'Offline Todo',
                      subtitle: 'SQLite • Bloc • CRUD',
                      icon: LucideIcons.checkCircle,
                      color: AppColors.primary,
                      isActive: true,
                      onTap: () => context.pushRoute(const TodoRoute()),
                    ),
                    AppCard(
                      title: 'Dynamic Form',
                      subtitle: 'Form Builder • Validation',
                      icon: LucideIcons.fileText,
                      color: AppColors.secondary,
                      isActive: true,
                      onTap: () => context.pushRoute(const DynamicFormRoute()),
                    ),
                    AppCard(
                      title: 'Mini Ecommerce',
                      subtitle: 'Cart • Products • Payment',
                      icon: LucideIcons.shoppingCart,
                      color: AppColors.success,
                      isActive: true,
                      onTap: () => context.pushRoute(const EcommerceRoute()),
                    ),
                    AppCard(
                      title: 'Method Channel',
                      subtitle: 'Native Integration',
                      icon: LucideIcons.smartphone,
                      color: AppColors.warning,
                      isActive: true,
                      onTap: () =>
                          context.pushRoute(const MethodChannelRoute()),
                    ),
                    AppCard(
                      title: 'Nested Bottom Nav',
                      subtitle: 'Complex Navigation',
                      icon: LucideIcons.navigation,
                      color: AppColors.info,
                      isActive: true,
                      onTap: () =>
                          context.pushRoute(const NestedBottomNavRoute()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
