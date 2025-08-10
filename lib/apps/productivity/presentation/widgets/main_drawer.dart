import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../themes/app_theme.dart';
import '../bloc/productivity_navigation_bloc.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductivityNavigationBloc, ProductivityNavigationState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: AppColors.surface,
          child: Column(
            children: [
              // Header
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withAlpha((0.8 * 255).toInt()),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha((0.2 * 255).toInt()),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            LucideIcons.trendingUp,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Productivity App',
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Manage your goals & finances',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white.withAlpha((0.8 * 255).toInt()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Menu Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  children: [
                    _buildMenuItem(
                      context,
                      state,
                      'Personal Management',
                      'Goals, Tasks & Progress',
                      LucideIcons.user,
                      ProductivityModule.personalManagement,
                    ),
                    _buildMenuItem(
                      context,
                      state,
                      'Financial Management',
                      'Income, Expenses & Budgets',
                      LucideIcons.dollarSign,
                      ProductivityModule.financialManagement,
                    ),
                    _buildMenuItem(
                      context,
                      state,
                      'Settings',
                      'Preferences & Configuration',
                      LucideIcons.settings,
                      ProductivityModule.settings,
                    ),
                  ],
                ),
              ),
              
              // Footer
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Divider(color: AppColors.outline.withAlpha((0.3 * 255).toInt())),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.info,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Version 1.0.0',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    ProductivityNavigationState state,
    String title,
    String subtitle,
    IconData icon,
    ProductivityModule module,
  ) {
    final isSelected = state.selectedModule == module;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected 
            ? AppColors.primary.withAlpha((0.1 * 255).toInt())
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          context.read<ProductivityNavigationBloc>().add(ModuleChanged(module));
          Navigator.of(context).pop();
        },
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected 
                ? AppColors.primary.withAlpha((0.2 * 255).toInt())
                : AppColors.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: isSelected 
            ? Icon(
                LucideIcons.check,
                color: AppColors.primary,
                size: 16,
              )
            : Icon(
                LucideIcons.chevronRight,
                color: AppColors.textHint,
                size: 16,
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
