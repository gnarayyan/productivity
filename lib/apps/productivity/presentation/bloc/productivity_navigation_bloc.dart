import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'productivity_navigation_event.dart';
part 'productivity_navigation_state.dart';

class ProductivityNavigationBloc extends Bloc<ProductivityNavigationEvent, ProductivityNavigationState> {
  ProductivityNavigationBloc() : super(const ProductivityNavigationState(
    selectedModule: ProductivityModule.personalManagement,
    selectedPersonalTab: PersonalTab.goals,
  )) {
    on<ModuleChanged>(_onModuleChanged);
    on<PersonalTabChanged>(_onPersonalTabChanged);
  }

  void _onModuleChanged(ModuleChanged event, Emitter<ProductivityNavigationState> emit) {
    emit(state.copyWith(selectedModule: event.module));
  }

  void _onPersonalTabChanged(PersonalTabChanged event, Emitter<ProductivityNavigationState> emit) {
    emit(state.copyWith(selectedPersonalTab: event.tab));
  }
}
