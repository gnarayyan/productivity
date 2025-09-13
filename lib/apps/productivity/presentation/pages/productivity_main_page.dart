import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:varosa_tech/apps/productivity/presentation/widgets/personal_management/create_goal_page.dart';

import '../../../../core/service_locator.dart';
import '../../../../themes/app_theme.dart';
import '../bloc/productivity_navigation_bloc.dart';
import '../widgets/dashboard/personal_dashboard_page.dart';
import '../widgets/main_drawer.dart';
import '../widgets/personal_management/create_task_page.dart';
import '../widgets/personal_management/personal_calendar_page.dart';
import '../widgets/personal_management/personal_goals_page.dart';
import '../widgets/personal_management/personal_tasks_page.dart';
import '../widgets/settings/settings_page.dart';

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
        final theme = Theme.of(context);

        final String? appbarText = _getAppBarWidget(
          state.selectedModule,
          state.selectedPersonalTab,
        );

        return Scaffold(
          backgroundColor: theme.brightness == Brightness.dark
              ? const Color(0xFF121212)
              : const Color(0xFFF5F5F5),
          drawer: const MainDrawer(),
          appBar: appbarText == null
              ? null
              : AppBar(
                  backgroundColor: theme.brightness == Brightness.dark
                      ? const Color(0xFF121212)
                      : const Color(0xFFF5F5F5),
                  elevation: 0,
                  // automaticallyImplyLeading: false,
                  title: Text(
                    appbarText,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),

          body: SafeArea(
            child: _getBodyWidget(
              state.selectedModule,
              state.selectedPersonalTab,
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context, state),
          floatingActionButton:
              state.selectedModule == ProductivityModule.personalManagement
              ? CustomFAB(tab: state.selectedPersonalTab)
              : null,
        );
      },
    );
  }

  // Widget _buildFloatingActionButton(BuildContext context) {
  //   return AnimatedSwitcher(
  //     duration: const Duration(milliseconds: 300),
  //     child: FloatingActionButton.extended(
  //       key: const ValueKey('fab'),
  //       heroTag: "productivity_main_fab", // Add unique hero tag
  //       onPressed: () {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) => const CreateGoalPage(),
  //             fullscreenDialog: true,
  //           ),
  //         );
  //       },
  //       backgroundColor:
  //           AppColors.primary, // Blue color consistent with goals page
  //       foregroundColor: Colors.white,
  //       icon: const Icon(LucideIcons.plus),
  //       label: const Text('Add Goal'),
  //     ),
  //   );
  // }

  String? _getAppBarWidget(ProductivityModule module, PersonalTab personalTab) {
    switch (module) {
      case ProductivityModule.personalManagement:
        switch (personalTab) {
          case PersonalTab.goals:
            return 'Goals';

          case PersonalTab.tasks:
            return 'Tasks';

          default:
            return null;
        }

      case ProductivityModule.financialManagement:
        return null;
      case ProductivityModule.settings:
        return null;
    }
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
        return const SettingsPage();
    }
  }

  Widget _getPersonalManagementWidget(PersonalTab tab) {
    switch (tab) {
      case PersonalTab.dashboard:
        return const PersonalDashboardPage();
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

    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
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
        backgroundColor: theme.brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
            : Colors.white,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.brightness == Brightness.dark
            ? Colors.grey.shade400
            : Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
        unselectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
          color: theme.brightness == Brightness.dark
              ? Colors.grey.shade400
              : Colors.grey.shade600,
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

    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary.withAlpha((0.1 * 255).toInt())
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isSelected
                ? theme.colorScheme.primary
                : (theme.brightness == Brightness.dark
                      ? Colors.grey.shade400
                      : Colors.grey.shade600),
          ),
        );
      },
    );
  }
}

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key, required this.tab});
  final PersonalTab tab;

  @override
  Widget build(BuildContext context) {
    final isGoal = tab == PersonalTab.goals;
    final isTasks = tab == PersonalTab.tasks;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: FloatingActionButton.extended(
        key: const ValueKey('fab'),
        heroTag: "productivity_main_fab", // Add unique hero tag
        onPressed: () {
          if (isGoal || isTasks) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    isGoal ? const CreateGoalPage() : const CreateTaskPage(),
                fullscreenDialog: true,
              ),
            );
          }

          // Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => const CreateTaskPage(),
          //         ),
          //       );
        },
        backgroundColor:
            AppColors.primary, // Blue color consistent with goals page
        foregroundColor: Colors.white,
        icon: const Icon(LucideIcons.plus),
        label: Text('Add ${isGoal ? "Goal" : "Task"}'),
      ),
    );
  }
}
