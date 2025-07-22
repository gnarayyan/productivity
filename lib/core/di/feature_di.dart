import 'package:get_it/get_it.dart';

/// Abstract interface for feature module dependency injection
///
/// Each feature module should implement this interface to provide
/// a standardized way of registering and unregistering dependencies
abstract class FeatureDI {
  /// Register all dependencies for this feature module
  void registerDependencies(GetIt serviceLocator);

  /// Unregister all dependencies for this feature module
  /// Useful for testing, hot restart, or feature toggling
  void unregisterDependencies(GetIt serviceLocator);
}

/// Mixin that provides common DI functionality
mixin DIHelpers {
  /// Safely register a dependency only if it's not already registered
  void safeRegister<T extends Object>(
    GetIt sl,
    T Function() factory, {
    bool lazy = true,
  }) {
    if (!sl.isRegistered<T>()) {
      if (lazy) {
        sl.registerLazySingleton<T>(factory);
      } else {
        sl.registerSingleton<T>(factory());
      }
    }
  }

  /// Safely register a factory only if it's not already registered
  void safeRegisterFactory<T extends Object>(GetIt sl, T Function() factory) {
    if (!sl.isRegistered<T>()) {
      sl.registerFactory<T>(factory);
    }
  }

  /// Safely unregister a dependency if it exists
  void safeUnregister<T extends Object>(GetIt sl) {
    if (sl.isRegistered<T>()) {
      sl.unregister<T>();
    }
  }
}
