import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class LoadTheme extends ThemeEvent {
  const LoadTheme();
}

class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

class SetTheme extends ThemeEvent {

  const SetTheme({required this.isDarkMode});
  final bool isDarkMode;

  @override
  List<Object?> get props => [isDarkMode];
}
