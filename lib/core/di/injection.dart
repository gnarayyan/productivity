import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Import the generated file
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
