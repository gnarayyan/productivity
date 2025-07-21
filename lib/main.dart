import 'package:flutter/material.dart';
import 'package:varosa_tech/core/app.dart';
import 'core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(); // Register everything
  runApp(App());
}
