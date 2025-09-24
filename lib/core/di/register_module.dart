// lib/core/di/register_module.dart

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Assuming you have Isar schemas defined, e.g., UserSchema
// import 'package:your_app/data/schemas/user_schema.dart';

@module
abstract class RegisterModule {
  // --- DIO ---
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );
    // You can add interceptors here
    return dio;
  }

  // --- SHARED PREFERENCES ---
  // @preResolve tells injectable to await this Future and register the result
  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // --- ISAR DATABASE ---
  // @preResolve
  // @lazySingleton
  // Future<Isar> get isar async {
  //   // final dir = await getApplicationDocumentsDirectory();
  //   // // Remember to add all your schemas here!
  //   // return Isar.open(
  //   //   [], // e.g., [UserSchema]
  //   //   directory: dir.path,
  //   // );
  // }
}
