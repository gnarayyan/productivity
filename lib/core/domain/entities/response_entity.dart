import 'package:equatable/equatable.dart';

abstract class ResponseEntity extends Equatable {
  const ResponseEntity();
  const ResponseEntity.fromMap(Map<String, dynamic> json);
}
