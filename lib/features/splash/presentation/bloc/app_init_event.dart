part of 'app_init_bloc.dart';

@freezed
class AppInitEvent with _$AppInitEvent {
  const factory AppInitEvent.started() = _Started;
  const factory AppInitEvent.retry() = _Retry;
}
