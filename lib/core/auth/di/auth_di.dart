import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/data/repositories/auth_remote_repository_impl.dart';
import '../../../features/auth/domain/repositories/auth_remote_repository.dart';
import '../../../features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../services/api_service.dart';

class AuthDI {
  static void registerDependencies(GetIt sl) {
    // Repository
    // sl.registerLazySingleton<AuthRemoteRepository>(
    //   () => AuthRemoteRepositoryImpl(sl<ApiService>(), sl<SharedPreferences>()),
    // );

    // Cubit
    // sl.registerFactory<AuthCubit>(() => AuthCubit(sl<AuthRemoteRepository>()));
  }

  static void unregisterDependencies(GetIt sl) {
    if (sl.isRegistered<AuthCubit>()) sl.unregister<AuthCubit>();
    if (sl.isRegistered<AuthRemoteRepository>())
      sl.unregister<AuthRemoteRepository>();
  }
}
