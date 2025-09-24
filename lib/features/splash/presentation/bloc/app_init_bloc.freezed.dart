// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_init_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppInitEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() retry,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? retry,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? retry,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Retry value) retry,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Retry value)? retry,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Retry value)? retry,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppInitEventCopyWith<$Res> {
  factory $AppInitEventCopyWith(
    AppInitEvent value,
    $Res Function(AppInitEvent) then,
  ) = _$AppInitEventCopyWithImpl<$Res, AppInitEvent>;
}

/// @nodoc
class _$AppInitEventCopyWithImpl<$Res, $Val extends AppInitEvent>
    implements $AppInitEventCopyWith<$Res> {
  _$AppInitEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppInitEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
    _$StartedImpl value,
    $Res Function(_$StartedImpl) then,
  ) = __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$AppInitEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
    _$StartedImpl _value,
    $Res Function(_$StartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppInitEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'AppInitEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() retry,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? retry,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? retry,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Retry value) retry,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Retry value)? retry,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Retry value)? retry,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements AppInitEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$RetryImplCopyWith<$Res> {
  factory _$$RetryImplCopyWith(
    _$RetryImpl value,
    $Res Function(_$RetryImpl) then,
  ) = __$$RetryImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RetryImplCopyWithImpl<$Res>
    extends _$AppInitEventCopyWithImpl<$Res, _$RetryImpl>
    implements _$$RetryImplCopyWith<$Res> {
  __$$RetryImplCopyWithImpl(
    _$RetryImpl _value,
    $Res Function(_$RetryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppInitEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RetryImpl implements _Retry {
  const _$RetryImpl();

  @override
  String toString() {
    return 'AppInitEvent.retry()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RetryImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() retry,
  }) {
    return retry();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? retry,
  }) {
    return retry?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? retry,
    required TResult orElse(),
  }) {
    if (retry != null) {
      return retry();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Retry value) retry,
  }) {
    return retry(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Retry value)? retry,
  }) {
    return retry?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Retry value)? retry,
    required TResult orElse(),
  }) {
    if (retry != null) {
      return retry(this);
    }
    return orElse();
  }
}

abstract class _Retry implements AppInitEvent {
  const factory _Retry() = _$RetryImpl;
}

/// @nodoc
mixin _$AppInitState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isFirstTimeUser, bool isAuthenticated)
    success,
    required TResult Function() noInternet,
    required TResult Function(String currentVersion, String requiredVersion)
    appUpdateRequired,
    required TResult Function(String message) maintenanceMode,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult? Function()? noInternet,
    TResult? Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult? Function(String message)? maintenanceMode,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult Function()? noInternet,
    TResult Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult Function(String message)? maintenanceMode,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_AppUpdateRequired value) appUpdateRequired,
    required TResult Function(_MaintenanceMode value) maintenanceMode,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult? Function(_MaintenanceMode value)? maintenanceMode,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult Function(_MaintenanceMode value)? maintenanceMode,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppInitStateCopyWith<$Res> {
  factory $AppInitStateCopyWith(
    AppInitState value,
    $Res Function(AppInitState) then,
  ) = _$AppInitStateCopyWithImpl<$Res, AppInitState>;
}

/// @nodoc
class _$AppInitStateCopyWithImpl<$Res, $Val extends AppInitState>
    implements $AppInitStateCopyWith<$Res> {
  _$AppInitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AppInitStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AppInitState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isFirstTimeUser, bool isAuthenticated)
    success,
    required TResult Function() noInternet,
    required TResult Function(String currentVersion, String requiredVersion)
    appUpdateRequired,
    required TResult Function(String message) maintenanceMode,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult? Function()? noInternet,
    TResult? Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult? Function(String message)? maintenanceMode,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult Function()? noInternet,
    TResult Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult Function(String message)? maintenanceMode,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_AppUpdateRequired value) appUpdateRequired,
    required TResult Function(_MaintenanceMode value) maintenanceMode,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult? Function(_MaintenanceMode value)? maintenanceMode,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult Function(_MaintenanceMode value)? maintenanceMode,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AppInitState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AppInitStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AppInitState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isFirstTimeUser, bool isAuthenticated)
    success,
    required TResult Function() noInternet,
    required TResult Function(String currentVersion, String requiredVersion)
    appUpdateRequired,
    required TResult Function(String message) maintenanceMode,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult? Function()? noInternet,
    TResult? Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult? Function(String message)? maintenanceMode,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult Function()? noInternet,
    TResult Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult Function(String message)? maintenanceMode,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_AppUpdateRequired value) appUpdateRequired,
    required TResult Function(_MaintenanceMode value) maintenanceMode,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult? Function(_MaintenanceMode value)? maintenanceMode,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult Function(_MaintenanceMode value)? maintenanceMode,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AppInitState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
    _$SuccessImpl value,
    $Res Function(_$SuccessImpl) then,
  ) = __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isFirstTimeUser, bool isAuthenticated});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$AppInitStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isFirstTimeUser = null, Object? isAuthenticated = null}) {
    return _then(
      _$SuccessImpl(
        isFirstTimeUser: null == isFirstTimeUser
            ? _value.isFirstTimeUser
            : isFirstTimeUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAuthenticated: null == isAuthenticated
            ? _value.isAuthenticated
            : isAuthenticated // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl({
    required this.isFirstTimeUser,
    required this.isAuthenticated,
  });

  @override
  final bool isFirstTimeUser;
  @override
  final bool isAuthenticated;

  @override
  String toString() {
    return 'AppInitState.success(isFirstTimeUser: $isFirstTimeUser, isAuthenticated: $isAuthenticated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.isFirstTimeUser, isFirstTimeUser) ||
                other.isFirstTimeUser == isFirstTimeUser) &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isFirstTimeUser, isAuthenticated);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isFirstTimeUser, bool isAuthenticated)
    success,
    required TResult Function() noInternet,
    required TResult Function(String currentVersion, String requiredVersion)
    appUpdateRequired,
    required TResult Function(String message) maintenanceMode,
    required TResult Function(String message) error,
  }) {
    return success(isFirstTimeUser, isAuthenticated);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult? Function()? noInternet,
    TResult? Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult? Function(String message)? maintenanceMode,
    TResult? Function(String message)? error,
  }) {
    return success?.call(isFirstTimeUser, isAuthenticated);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult Function()? noInternet,
    TResult Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult Function(String message)? maintenanceMode,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(isFirstTimeUser, isAuthenticated);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_AppUpdateRequired value) appUpdateRequired,
    required TResult Function(_MaintenanceMode value) maintenanceMode,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult? Function(_MaintenanceMode value)? maintenanceMode,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult Function(_MaintenanceMode value)? maintenanceMode,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements AppInitState {
  const factory _Success({
    required final bool isFirstTimeUser,
    required final bool isAuthenticated,
  }) = _$SuccessImpl;

  bool get isFirstTimeUser;
  bool get isAuthenticated;

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoInternetImplCopyWith<$Res> {
  factory _$$NoInternetImplCopyWith(
    _$NoInternetImpl value,
    $Res Function(_$NoInternetImpl) then,
  ) = __$$NoInternetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoInternetImplCopyWithImpl<$Res>
    extends _$AppInitStateCopyWithImpl<$Res, _$NoInternetImpl>
    implements _$$NoInternetImplCopyWith<$Res> {
  __$$NoInternetImplCopyWithImpl(
    _$NoInternetImpl _value,
    $Res Function(_$NoInternetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoInternetImpl implements _NoInternet {
  const _$NoInternetImpl();

  @override
  String toString() {
    return 'AppInitState.noInternet()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoInternetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isFirstTimeUser, bool isAuthenticated)
    success,
    required TResult Function() noInternet,
    required TResult Function(String currentVersion, String requiredVersion)
    appUpdateRequired,
    required TResult Function(String message) maintenanceMode,
    required TResult Function(String message) error,
  }) {
    return noInternet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult? Function()? noInternet,
    TResult? Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult? Function(String message)? maintenanceMode,
    TResult? Function(String message)? error,
  }) {
    return noInternet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult Function()? noInternet,
    TResult Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult Function(String message)? maintenanceMode,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_AppUpdateRequired value) appUpdateRequired,
    required TResult Function(_MaintenanceMode value) maintenanceMode,
    required TResult Function(_Error value) error,
  }) {
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult? Function(_MaintenanceMode value)? maintenanceMode,
    TResult? Function(_Error value)? error,
  }) {
    return noInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult Function(_MaintenanceMode value)? maintenanceMode,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(this);
    }
    return orElse();
  }
}

abstract class _NoInternet implements AppInitState {
  const factory _NoInternet() = _$NoInternetImpl;
}

/// @nodoc
abstract class _$$AppUpdateRequiredImplCopyWith<$Res> {
  factory _$$AppUpdateRequiredImplCopyWith(
    _$AppUpdateRequiredImpl value,
    $Res Function(_$AppUpdateRequiredImpl) then,
  ) = __$$AppUpdateRequiredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String currentVersion, String requiredVersion});
}

/// @nodoc
class __$$AppUpdateRequiredImplCopyWithImpl<$Res>
    extends _$AppInitStateCopyWithImpl<$Res, _$AppUpdateRequiredImpl>
    implements _$$AppUpdateRequiredImplCopyWith<$Res> {
  __$$AppUpdateRequiredImplCopyWithImpl(
    _$AppUpdateRequiredImpl _value,
    $Res Function(_$AppUpdateRequiredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? currentVersion = null, Object? requiredVersion = null}) {
    return _then(
      _$AppUpdateRequiredImpl(
        currentVersion: null == currentVersion
            ? _value.currentVersion
            : currentVersion // ignore: cast_nullable_to_non_nullable
                  as String,
        requiredVersion: null == requiredVersion
            ? _value.requiredVersion
            : requiredVersion // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AppUpdateRequiredImpl implements _AppUpdateRequired {
  const _$AppUpdateRequiredImpl({
    required this.currentVersion,
    required this.requiredVersion,
  });

  @override
  final String currentVersion;
  @override
  final String requiredVersion;

  @override
  String toString() {
    return 'AppInitState.appUpdateRequired(currentVersion: $currentVersion, requiredVersion: $requiredVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUpdateRequiredImpl &&
            (identical(other.currentVersion, currentVersion) ||
                other.currentVersion == currentVersion) &&
            (identical(other.requiredVersion, requiredVersion) ||
                other.requiredVersion == requiredVersion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentVersion, requiredVersion);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUpdateRequiredImplCopyWith<_$AppUpdateRequiredImpl> get copyWith =>
      __$$AppUpdateRequiredImplCopyWithImpl<_$AppUpdateRequiredImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isFirstTimeUser, bool isAuthenticated)
    success,
    required TResult Function() noInternet,
    required TResult Function(String currentVersion, String requiredVersion)
    appUpdateRequired,
    required TResult Function(String message) maintenanceMode,
    required TResult Function(String message) error,
  }) {
    return appUpdateRequired(currentVersion, requiredVersion);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult? Function()? noInternet,
    TResult? Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult? Function(String message)? maintenanceMode,
    TResult? Function(String message)? error,
  }) {
    return appUpdateRequired?.call(currentVersion, requiredVersion);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult Function()? noInternet,
    TResult Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult Function(String message)? maintenanceMode,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (appUpdateRequired != null) {
      return appUpdateRequired(currentVersion, requiredVersion);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_AppUpdateRequired value) appUpdateRequired,
    required TResult Function(_MaintenanceMode value) maintenanceMode,
    required TResult Function(_Error value) error,
  }) {
    return appUpdateRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult? Function(_MaintenanceMode value)? maintenanceMode,
    TResult? Function(_Error value)? error,
  }) {
    return appUpdateRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult Function(_MaintenanceMode value)? maintenanceMode,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (appUpdateRequired != null) {
      return appUpdateRequired(this);
    }
    return orElse();
  }
}

abstract class _AppUpdateRequired implements AppInitState {
  const factory _AppUpdateRequired({
    required final String currentVersion,
    required final String requiredVersion,
  }) = _$AppUpdateRequiredImpl;

  String get currentVersion;
  String get requiredVersion;

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUpdateRequiredImplCopyWith<_$AppUpdateRequiredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MaintenanceModeImplCopyWith<$Res> {
  factory _$$MaintenanceModeImplCopyWith(
    _$MaintenanceModeImpl value,
    $Res Function(_$MaintenanceModeImpl) then,
  ) = __$$MaintenanceModeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MaintenanceModeImplCopyWithImpl<$Res>
    extends _$AppInitStateCopyWithImpl<$Res, _$MaintenanceModeImpl>
    implements _$$MaintenanceModeImplCopyWith<$Res> {
  __$$MaintenanceModeImplCopyWithImpl(
    _$MaintenanceModeImpl _value,
    $Res Function(_$MaintenanceModeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$MaintenanceModeImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MaintenanceModeImpl implements _MaintenanceMode {
  const _$MaintenanceModeImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AppInitState.maintenanceMode(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaintenanceModeImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MaintenanceModeImplCopyWith<_$MaintenanceModeImpl> get copyWith =>
      __$$MaintenanceModeImplCopyWithImpl<_$MaintenanceModeImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isFirstTimeUser, bool isAuthenticated)
    success,
    required TResult Function() noInternet,
    required TResult Function(String currentVersion, String requiredVersion)
    appUpdateRequired,
    required TResult Function(String message) maintenanceMode,
    required TResult Function(String message) error,
  }) {
    return maintenanceMode(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult? Function()? noInternet,
    TResult? Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult? Function(String message)? maintenanceMode,
    TResult? Function(String message)? error,
  }) {
    return maintenanceMode?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult Function()? noInternet,
    TResult Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult Function(String message)? maintenanceMode,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (maintenanceMode != null) {
      return maintenanceMode(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_AppUpdateRequired value) appUpdateRequired,
    required TResult Function(_MaintenanceMode value) maintenanceMode,
    required TResult Function(_Error value) error,
  }) {
    return maintenanceMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult? Function(_MaintenanceMode value)? maintenanceMode,
    TResult? Function(_Error value)? error,
  }) {
    return maintenanceMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult Function(_MaintenanceMode value)? maintenanceMode,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (maintenanceMode != null) {
      return maintenanceMode(this);
    }
    return orElse();
  }
}

abstract class _MaintenanceMode implements AppInitState {
  const factory _MaintenanceMode({required final String message}) =
      _$MaintenanceModeImpl;

  String get message;

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MaintenanceModeImplCopyWith<_$MaintenanceModeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$AppInitStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AppInitState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool isFirstTimeUser, bool isAuthenticated)
    success,
    required TResult Function() noInternet,
    required TResult Function(String currentVersion, String requiredVersion)
    appUpdateRequired,
    required TResult Function(String message) maintenanceMode,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult? Function()? noInternet,
    TResult? Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult? Function(String message)? maintenanceMode,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool isFirstTimeUser, bool isAuthenticated)? success,
    TResult Function()? noInternet,
    TResult Function(String currentVersion, String requiredVersion)?
    appUpdateRequired,
    TResult Function(String message)? maintenanceMode,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_AppUpdateRequired value) appUpdateRequired,
    required TResult Function(_MaintenanceMode value) maintenanceMode,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult? Function(_MaintenanceMode value)? maintenanceMode,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_AppUpdateRequired value)? appUpdateRequired,
    TResult Function(_MaintenanceMode value)? maintenanceMode,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AppInitState {
  const factory _Error({required final String message}) = _$ErrorImpl;

  String get message;

  /// Create a copy of AppInitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
