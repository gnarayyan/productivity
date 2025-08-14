part of 'productivity_navigation_bloc.dart';

enum ProductivityModule { personalManagement, financialManagement, settings }

enum PersonalTab { dashboard, tasks, goals, calendar }

class ProductivityNavigationState extends Equatable {
  final ProductivityModule selectedModule;
  final PersonalTab selectedPersonalTab;

  const ProductivityNavigationState({
    required this.selectedModule,
    required this.selectedPersonalTab,
  });

  ProductivityNavigationState copyWith({
    ProductivityModule? selectedModule,
    PersonalTab? selectedPersonalTab,
  }) {
    return ProductivityNavigationState(
      selectedModule: selectedModule ?? this.selectedModule,
      selectedPersonalTab: selectedPersonalTab ?? this.selectedPersonalTab,
    );
  }

  bool get isGoalsPage =>
      selectedModule == ProductivityModule.personalManagement &&
      selectedPersonalTab == PersonalTab.goals;

  @override
  List<Object?> get props => [selectedModule, selectedPersonalTab];
}
