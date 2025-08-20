import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';

  ThemeBloc() : super(const ThemeState()) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
    on<SetTheme>(_onSetTheme);

    // Load saved theme on initialization
    add(LoadTheme());
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_themeKey) ?? false;
      emit(state.copyWith(isDarkMode: isDark));
    } catch (e) {
      // If there's an error loading preferences, use light theme as default
      emit(state.copyWith(isDarkMode: false));
    }
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final newTheme = !state.isDarkMode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, newTheme);
      emit(state.copyWith(isDarkMode: newTheme));
    } catch (e) {
      // If there's an error saving preferences, still toggle but show error
      emit(
        state.copyWith(
          isDarkMode: !state.isDarkMode,
          error: 'Failed to save theme preference',
        ),
      );
    }
  }

  Future<void> _onSetTheme(SetTheme event, Emitter<ThemeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, event.isDarkMode);
      emit(state.copyWith(isDarkMode: event.isDarkMode));
    } catch (e) {
      // If there's an error saving preferences, still set theme but show error
      emit(
        state.copyWith(
          isDarkMode: event.isDarkMode,
          error: 'Failed to save theme preference',
        ),
      );
    }
  }
}
