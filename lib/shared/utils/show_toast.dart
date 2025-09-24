import 'package:varosa_tech/core/error/exceptions.dart';

class ShowToast {
  static void error(CustomException exception) {
    print(exception.message);
  }

  static void success(String message) {
    print(message);
  }
}
