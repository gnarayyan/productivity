// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar/isar.dart' as _i338;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:varosa_tech/core/di/register_module.dart' as _i115;
import 'package:varosa_tech/core/services/api_service.dart' as _i780;
import 'package:varosa_tech/core/themes/bloc/theme_bloc.dart' as _i406;
import 'package:varosa_tech/features/auth/data/repositories/auth_local_repository_impl.dart'
    as _i41;
import 'package:varosa_tech/features/auth/data/repositories/auth_remote_repository_impl.dart'
    as _i52;
import 'package:varosa_tech/features/auth/domain/repositories/auth_local_repository.dart'
    as _i252;
import 'package:varosa_tech/features/auth/domain/repositories/auth_remote_repository.dart'
    as _i725;
import 'package:varosa_tech/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart'
    as _i479;
import 'package:varosa_tech/features/settings/presentation/settings_bloc/settings_bloc.dart'
    as _i299;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i406.ThemeBloc>(() => _i406.ThemeBloc());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i299.SettingsBloc>(
      () => _i299.SettingsBloc(gh<_i460.SharedPreferences>(), gh<_i338.Isar>()),
    );
    gh.lazySingleton<_i252.AuthLocalRepository>(
      () => _i41.AuthLocalRepositoryImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i725.AuthRemoteRepository>(
      () => _i52.AuthRemoteRepositoryImpl(gh<_i780.ApiService>()),
    );
    gh.factory<_i479.AuthCubit>(
      () => _i479.AuthCubit(
        gh<_i725.AuthRemoteRepository>(),
        gh<_i252.AuthLocalRepository>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i115.RegisterModule {}
