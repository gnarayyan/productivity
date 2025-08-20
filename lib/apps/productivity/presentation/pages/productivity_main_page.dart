import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:varosa_tech/apps/productivity/presentation/widgets/personal_management/create_goal_page.dart';
import '../../../../core/service_locator.dart';
import '../../../../themes/app_theme.dart';
import '../bloc/productivity_navigation_bloc.dart';
import '../widgets/main_drawer.dart';
import '../widgets/personal_management/personal_dashboard.dart';
import '../widgets/personal_management/personal_goals_page.dart';
import '../widgets/personal_management/personal_tasks_page.dart';
import '../widgets/personal_management/personal_calendar_page.dart';

@RoutePage()
class ProductivityMainPage extends StatelessWidget {
  const ProductivityMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductivityNavigationBloc>(),
      child: const ProductivityMainView(),
    );
  }
}

class ProductivityMainView extends StatelessWidget {
  const ProductivityMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductivityNavigationBloc, ProductivityNavigationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          drawer: const MainDrawer(),
          body: SafeArea(
            child: _getBodyWidget(
              state.selectedModule,
              state.selectedPersonalTab,
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context, state),
          floatingActionButton: state.isGoalsPage
              ? _buildFloatingActionButton(context)
              : null,
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: FloatingActionButton.extended(
        key: const ValueKey('fab'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateGoalPage(),
              fullscreenDialog: true,
            ),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        icon: const Icon(LucideIcons.plus),
        label: const Text('Add Goal'),
      ),
    );
  }

  Widget _getBodyWidget(ProductivityModule module, PersonalTab personalTab) {
    switch (module) {
      case ProductivityModule.personalManagement:
        return _getPersonalManagementWidget(personalTab);
      case ProductivityModule.financialManagement:
        return const Center(
          child: Text(
            'Financial Management\nComing Soon!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        );
      case ProductivityModule.settings:
        return const Center(
          child: Text(
            'Settings\nComing Soon!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        );
    }
  }

  Widget _getPersonalManagementWidget(PersonalTab tab) {
    switch (tab) {
      case PersonalTab.dashboard:
        return const PersonalDashboard();
      case PersonalTab.tasks:
        return const PersonalTasksPage();
      case PersonalTab.goals:
        return const PersonalGoalsPage();
      case PersonalTab.calendar:
        return const PersonalCalendarPage();
    }
  }

  Widget? _buildBottomNavigationBar(
    BuildContext context,
    ProductivityNavigationState state,
  ) {
    if (state.selectedModule != ProductivityModule.personalManagement) {
      return null;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha((0.1 * 255).toInt()),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: state.selectedPersonalTab.index,
        onTap: (index) {
          context.read<ProductivityNavigationBloc>().add(
            PersonalTabChanged(PersonalTab.values[index]),
          );
        },
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        unselectedLabelStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textHint,
        ),
        items: [
          BottomNavigationBarItem(
            icon: _buildNavIcon(
              LucideIcons.home,
              0,
              state.selectedPersonalTab.index,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(
              LucideIcons.checkSquare,
              1,
              state.selectedPersonalTab.index,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(
              LucideIcons.target,
              2,
              state.selectedPersonalTab.index,
            ),
            label: 'Goals',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(
              LucideIcons.calendar,
              3,
              state.selectedPersonalTab.index,
            ),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index, int selectedIndex) {
    final isSelected = index == selectedIndex;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withAlpha((0.1 * 255).toInt())
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.textHint,
      ),
    );
  }
}
