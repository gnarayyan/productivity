import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_init_bloc.freezed.dart';
part 'app_init_event.dart';
part 'app_init_state.dart';

class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  AppInitBloc() : super(const AppInitState.initial()) {
    on<AppInitEvent>((event, emit) async {
      await event.map(
        started: (_) async {
          emit(const AppInitState.loading());

          // Simulate app initialization steps (replace with real logic)
          await Future.delayed(const Duration(seconds: 1));

          const bool hasInternet = true;
          const bool requiresUpdate = false;
          const bool isInMaintenance = false;
          const bool isFirstTime = false;
          const bool isAuthenticated = true;

          if (!hasInternet) {
            emit(const AppInitState.noInternet());
          } else if (requiresUpdate) {
            emit(
              const AppInitState.appUpdateRequired(
                currentVersion: '1.0.0',
                requiredVersion: '1.1.0',
              ),
            );
          } else if (isInMaintenance) {
            emit(
              const AppInitState.maintenanceMode(
                message: 'Server is under maintenance. Try again later.',
              ),
            );
          } else {
            emit(
              const AppInitState.success(
                isFirstTimeUser: isFirstTime,
                isAuthenticated: isAuthenticated,
              ),
            );
          }
        },
        retry: (_) async {
          add(const AppInitEvent.started());
        },
      );
    });
  }
}
