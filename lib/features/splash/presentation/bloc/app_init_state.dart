part of 'app_init_bloc.dart';


@freezed
class AppInitState with _$AppInitState {
  const factory AppInitState.initial() = _Initial;

  const factory AppInitState.loading() = _Loading;

  const factory AppInitState.success({
    required bool isFirstTimeUser,
    required bool isAuthenticated,
  }) = _Success;

  const factory AppInitState.noInternet() = _NoInternet;

  const factory AppInitState.appUpdateRequired({
    required String currentVersion,
    required String requiredVersion,
  }) = _AppUpdateRequired;

  const factory AppInitState.maintenanceMode({
    required String message,
  }) = _MaintenanceMode;

  const factory AppInitState.error({
    required String message,
  }) = _Error;
}
