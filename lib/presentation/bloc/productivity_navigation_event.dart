part of 'productivity_navigation_bloc.dart';

abstract class ProductivityNavigationEvent extends Equatable {
  const ProductivityNavigationEvent();

  @override
  List<Object?> get props => [];
}

class ModuleChanged extends ProductivityNavigationEvent {

  const ModuleChanged(this.module);
  final ProductivityModule module;

  @override
  List<Object?> get props => [module];
}

class PersonalTabChanged extends ProductivityNavigationEvent {

  const PersonalTabChanged(this.tab);
  final PersonalTab tab;

  @override
  List<Object?> get props => [tab];
}
