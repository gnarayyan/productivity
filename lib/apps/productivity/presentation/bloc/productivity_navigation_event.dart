part of 'productivity_navigation_bloc.dart';

abstract class ProductivityNavigationEvent extends Equatable {
  const ProductivityNavigationEvent();

  @override
  List<Object?> get props => [];
}

class ModuleChanged extends ProductivityNavigationEvent {
  final ProductivityModule module;

  const ModuleChanged(this.module);

  @override
  List<Object?> get props => [module];
}

class PersonalTabChanged extends ProductivityNavigationEvent {
  final PersonalTab tab;

  const PersonalTabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
}
