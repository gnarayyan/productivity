import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences _prefs;
  final Isar _isar;
  SettingsBloc(this._prefs, this._isar) : super(const _Initial()) {
    on<SettingsEvent>((event, emit) {
      // Use _prefs or _isar to handle logic
      final theme = _prefs.getString('theme');
      print('Current theme is $theme');
    });
  }
}
