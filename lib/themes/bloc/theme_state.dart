import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {

  const ThemeState({this.isDarkMode = false, this.error});
  final bool isDarkMode;
  final String? error;

  ThemeState copyWith({bool? isDarkMode, String? error}) {
    return ThemeState(isDarkMode: isDarkMode ?? this.isDarkMode, error: error);
  }

  @override
  List<Object?> get props => [isDarkMode, error];
}
