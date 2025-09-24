import 'package:flutter/material.dart';
import 'package:varosa_tech/app.dart';
import 'package:varosa_tech/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const App());
}
