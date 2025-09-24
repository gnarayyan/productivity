#!/usr/bin/env dart

import 'dart:io';

import 'utils/parse_data_fields.dart';

/// Feature Generator for Flutter Clean Architecture
///
/// This tool generates a complete feature structure following clean architecture principles
/// with boilerplate code for data, domain, and presentation layers.
///
/// Usage: dart run cmd/generate_feature.dart
void main() async {
  print('🚀 Flutter Feature Generator - Clean Architecture');
  print('=' * 50);

  try {
    final generator = FeatureGenerator();
    await generator.run();
  } catch (e) {
    print('❌ Error: $e');
    exit(1);
  }
}

class FeatureGenerator {
  late String featureName;
  late String featurePath;
  late List<DataField> dataFields;
  late bool generateJson;

  Future<void> run() async {
    // Get user inputs
    await _getUserInputs();

    // Generate feature structure
    await _generateFeatureStructure();

    print('\n✅ Feature "$featureName" generated successfully!');
    print('📁 Location: $featurePath');
    print('\n🎯 Next steps:');
    print('   1. Add your feature to the main app routing');
    print('   2. Register dependencies in your service locator');
    print('   3. Import and use the generated BLoC in your widgets');
  }

  Future<void> _getUserInputs() async {
    // Get feature name
    stdout.write('Enter feature name: ');
    featureName = stdin.readLineSync()?.trim() ?? '';

    if (featureName.isEmpty) {
      throw 'Feature name cannot be empty';
    }

    // Validate feature name (should be snake_case)
    if (!RegExp(r'^[a-z_][a-z0-9_]*$').hasMatch(featureName)) {
      throw 'Feature name should be in snake_case (e.g., user_profile, product_catalog)';
    }

    // Get feature path
    final defaultPath = 'lib/features/$featureName';
    stdout.write('Path to put feature (default: $defaultPath): ');
    final inputPath = stdin.readLineSync()?.trim() ?? '';
    featurePath = inputPath.isEmpty ? defaultPath : inputPath;

    // Get data fields
    stdout.write(
      'Enter data fields (e.g., id:int name:string price:double author?:User): ',
    );
    final fieldsInput = stdin.readLineSync()?.trim() ?? '';
    dataFields = _parseDataFields(fieldsInput);

    if (dataFields.isEmpty) {
      print('⚠️  No data fields provided. Adding default "id:int" field.');
      dataFields = [DataField('id', 'int', false)];
    }

    // Ask about JSON generation
    stdout.write('Generate fromJson/toJson methods? (y/N): ');
    final jsonInput = stdin.readLineSync()?.trim().toLowerCase() ?? 'n';
    generateJson = jsonInput == 'y' || jsonInput == 'yes';

    // Confirmation
    print('\n📋 Summary:');
    print('   Feature: $featureName');
    print('   Path: $featurePath');
    print(
      '   Fields: ${dataFields.map((f) => '${f.name}:${f.type}${f.isOptional ? '?' : ''}').join(', ')}',
    );
    print('   JSON methods: ${generateJson ? 'Yes' : 'No'}');

    stdout.write('\nProceed? (Y/n): ');
    final confirm = stdin.readLineSync()?.trim().toLowerCase() ?? 'y';
    if (confirm == 'n' || confirm == 'no') {
      print('Cancelled.');
      exit(0);
    }
  }

  List<DataField> _parseDataFields(String input) {
    if (input.isEmpty) return [];

    final fields = <DataField>[];
    final parts = input.split(' ');

    for (final part in parts) {
      final colonIndex = part.indexOf(':');
      if (colonIndex == -1) continue;

      final nameWithOptional = part.substring(0, colonIndex);
      final type = parseAndValidateDataType(
        part.substring(colonIndex + 1),
      ); // TODO: parse data type

      final isOptional = nameWithOptional.endsWith('?');
      final name = isOptional
          ? nameWithOptional.substring(0, nameWithOptional.length - 1)
          : nameWithOptional;

      fields.add(DataField(name, type, isOptional));
    }

    return fields;
  }

  Future<void> _generateFeatureStructure() async {
    final basePath = Directory(featurePath);

    // Create directory structure
    await _createDirectories(basePath);

    // Generate files
    await _generateDataLayer(basePath);
    await _generateDomainLayer(basePath);
    await _generatePresentationLayer(basePath);

    print('\n📁 Generated structure:');
    await _printDirectoryTree(basePath, '');
  }

  Future<void> _createDirectories(Directory basePath) async {
    final dirs = [
      'data/datasources',
      'data/models',
      'data/repositories',
      'data/services',
      'domain/entities',
      'domain/repositories',
      'domain/usecases',
      'presentation/blocs/$featureName',
      'presentation/screens',
      'presentation/widgets',
    ];

    for (final dir in dirs) {
      await Directory('${basePath.path}/$dir').create(recursive: true);
    }
  }

  Future<void> _generateDataLayer(Directory basePath) async {
    // Generate model
    await _generateModel(basePath);

    // Generate remote data source
    await _generateRemoteDataSource(basePath);

    // Generate repository implementation
    await _generateRepositoryImpl(basePath);

    // Generate API service
    // await _generateApiService(basePath);
  }

  Future<void> _generateDomainLayer(Directory basePath) async {
    // Generate entity
    await _generateEntity(basePath);

    // Generate repository interface
    await _generateRepository(basePath);

    // Generate use case
    await _generateUseCase(basePath);
  }

  Future<void> _generatePresentationLayer(Directory basePath) async {
    // Generate BLoC files
    await _generateBlocEvent(basePath);
    await _generateBlocState(basePath);
    await _generateBloc(basePath);

    // Generate screen
    await _generateScreen(basePath);

    // Generate widgets
    await _generateWidgets(basePath);
  }

  Future<void> _generateModel(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File('${basePath.path}/data/models/${featureName}_model.dart');

    final buffer = StringBuffer();
    buffer.writeln("import '../../domain/entities/$featureName.dart';");
    buffer.writeln();

    // Class definition
    buffer.writeln('class ${className}Model extends $className {');

    // Constructor
    buffer.write('  const ${className}Model({');
    for (int i = 0; i < dataFields.length; i++) {
      final field = dataFields[i];
      buffer.write('${field.isOptional ? '' : 'required '}super.${field.name}');
      if (i < dataFields.length - 1) buffer.write(', ');
    }
    buffer.writeln('});');
    buffer.writeln();

    // Factory constructor from entity
    buffer.writeln(
      '  factory ${className}Model.fromEntity($className entity) {',
    );
    buffer.writeln('    return ${className}Model(');
    for (final field in dataFields) {
      buffer.writeln('      ${field.name}: entity.${field.name},');
    }
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    if (generateJson) {
      // fromJson
      buffer.writeln(
        '  factory ${className}Model.fromJson(Map<String, dynamic> json) {',
      );
      buffer.writeln('    return ${className}Model(');
      for (final field in dataFields) {
        final jsonKey = _toSnakeCase(field.name);
        buffer.writeln(
          '      ${field.name}: ${_getFromJsonConversion(field, jsonKey)},',
        );
      }
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();

      // toJson
      buffer.writeln('  Map<String, dynamic> toJson() {');
      buffer.writeln('    return {');
      for (final field in dataFields) {
        final jsonKey = _toSnakeCase(field.name);
        buffer.writeln('      \'$jsonKey\': ${_getToJsonConversion(field)},');
      }
      buffer.writeln('    };');
      buffer.writeln('  }');
      buffer.writeln();
    }

    // fromMap
    buffer.writeln(
      '  factory ${className}Model.fromMap(Map<String, dynamic> map) {',
    );
    buffer.writeln('    return ${className}Model(');
    for (final field in dataFields) {
      buffer.writeln('      ${field.name}: ${_getFromMapConversion(field)},');
    }
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    // toMap
    buffer.writeln('  Map<String, dynamic> toMap() {');
    buffer.writeln('    return {');
    for (final field in dataFields) {
      buffer.writeln('      \'${field.name}\': ${field.name},');
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    // copyWith
    buffer.writeln('  ${className}Model copyWith({');
    for (final field in dataFields) {
      buffer.writeln(
        '    ${field.isOptional ? field.type : '${field.type}?'} ${field.name},',
      );
    }
    buffer.writeln('  }) {');
    buffer.writeln('    return ${className}Model(');
    for (final field in dataFields) {
      buffer.writeln(
        '      ${field.name}: ${field.name} ?? this.${field.name},',
      );
    }
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('}');

    await file.writeAsString(buffer.toString());
  }

  Future<void> _generateEntity(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File('${basePath.path}/domain/entities/$featureName.dart');

    final buffer = StringBuffer();
    buffer.writeln('import \'package:equatable/equatable.dart\';');
    buffer.writeln();
    buffer.writeln('class $className extends Equatable {');

    // Properties
    for (final field in dataFields) {
      buffer.writeln(
        '  final ${field.type}${field.isOptional ? '?' : ''} ${field.name};',
      );
    }
    buffer.writeln();

    // Constructor
    buffer.write('  const $className({');
    for (int i = 0; i < dataFields.length; i++) {
      final field = dataFields[i];
      buffer.write('${field.isOptional ? '' : 'required '}this.${field.name}');
      if (i < dataFields.length - 1) buffer.write(', ');
    }
    buffer.writeln('});');
    buffer.writeln();

    // Props for Equatable
    buffer.writeln('  @override');
    buffer.write(
      '  List<Object${dataFields.any((f) => f.isOptional) ? '?' : ''}> get props => [',
    );
    for (int i = 0; i < dataFields.length; i++) {
      buffer.write(dataFields[i].name);
      if (i < dataFields.length - 1) buffer.write(', ');
    }
    buffer.writeln('];');
    buffer.writeln();

    // toString
    buffer.writeln('  @override');
    buffer.writeln('  String toString() {');
    buffer.write('    return \'$className(');
    for (int i = 0; i < dataFields.length; i++) {
      final field = dataFields[i];
      buffer.write('${field.name}: \$${field.name}');
      if (i < dataFields.length - 1) buffer.write(', ');
    }
    buffer.writeln(')\';');
    buffer.writeln('  }');
    buffer.writeln('}');

    await file.writeAsString(buffer.toString());
  }

  Future<void> _generateRemoteDataSource(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File(
      '${basePath.path}/data/datasources/${featureName}_remote_data_source.dart',
    );

    final content =
        '''
import 'package:fpdart/fpdart.dart';
import 'package:varosa_tech/core/data/datasource/remote_datasource.dart';
import 'package:varosa_tech/core/error/exceptions.dart';
import 'package:varosa_tech/core/services/api_service.dart';
import 'package:varosa_tech/core/services/http_client.dart';
import 'package:varosa_tech/features/$featureName/data/models/${featureName}_model.dart';

class ${className}RemoteDataSourceImpl
    with HttpClient<${className}Model>
    implements RemoteDataSource<${className}Model> {
  @override
  final ApiService apiService;
  ${className}RemoteDataSourceImpl(this.apiService);

  @override
  final String path = '/${featureName}s';

  @override
  Future<Either<CustomException, List<${className}Model>>> getAll() =>
      fetchAll(fromMap: ${className}Model.fromMap);

  @override
  Future<Either<CustomException, ${className}Model>> get(String id) =>
      fetch(id: id, fromMap: ${className}Model.fromMap);

  @override
  Future<Either<CustomException, ${className}Model>> create(${className}Model $featureName) =>
      save(fromMap: ${className}Model.fromMap, data: $featureName.toMap());

  @override
  Future<Either<CustomException, ${className}Model>> update(${className}Model $featureName) =>
      modify(id: $featureName.id, fromMap: ${className}Model.fromMap, data: ${className.toLowerCase()}.toMap());

  @override
  Future<Either<CustomException, ${className}Model>> delete(String id) =>
      remove(id: id, fromMap: ${className}Model.fromMap);
}
''';

    await file.writeAsString(content);
  }

  Future<void> _generateRepositoryImpl(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File(
      '${basePath.path}/data/repositories/${featureName}_repository_impl.dart',
    );

    final content =
        '''
import 'package:fpdart/fpdart.dart';
import 'package:varosa_tech/core/data/datasource/remote_datasource.dart';
import 'package:varosa_tech/core/error/exceptions.dart';
import 'package:varosa_tech/features/$featureName/domain/entities/$featureName.dart';
import 'package:varosa_tech/features/$featureName/domain/repositories/${featureName}_remote_repository.dart';


class ${className}RepositoryImpl implements ${className}Repository {
  final RemoteDataSource<$className> remoteDataSource;

  ${className}RepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<CustomException, $className>> create($className $featureName) =>
      remoteDataSource.create($featureName);

  @override
  Future<Either<CustomException, $className>> delete(String id) =>
      remoteDataSource.delete(id);

  @override
  Future<Either<CustomException, $className>> get(String id) =>
      remoteDataSource.get(id);

  @override
  Future<Either<CustomException, List<$className>>> getAll() =>
      remoteDataSource.getAll();

  @override
  Future<Either<CustomException, $className>> update($className $featureName) =>
      remoteDataSource.update($featureName);
}
''';

    await file.writeAsString(content);
  }

  //   Future<void> _generateApiService(Directory basePath) async {
  //     final file = File('${basePath.path}/data/services/api_service.dart');

  //     const content = '''
  // import 'package:dio/dio.dart';

  // class ApiService {
  //   final Dio _dio;

  //   ApiService({required Dio dio}) : _dio = dio;

  //   Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
  //     try {
  //       return await _dio.get(path, queryParameters: queryParameters);
  //     } catch (e) {
  //       throw _handleError(e);
  //     }
  //   }

  //   Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
  //     try {
  //       return await _dio.post(path, data: data, queryParameters: queryParameters);
  //     } catch (e) {
  //       throw _handleError(e);
  //     }
  //   }

  //   Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
  //     try {
  //       return await _dio.put(path, data: data, queryParameters: queryParameters);
  //     } catch (e) {
  //       throw _handleError(e);
  //     }
  //   }

  //   Future<Response> delete(String path, {Map<String, dynamic>? queryParameters}) async {
  //     try {
  //       return await _dio.delete(path, queryParameters: queryParameters);
  //     } catch (e) {
  //       throw _handleError(e);
  //     }
  //   }

  //   Exception _handleError(dynamic error) {
  //     if (error is DioException) {
  //       switch (error.type) {
  //         case DioExceptionType.connectionTimeout:
  //         case DioExceptionType.sendTimeout:
  //         case DioExceptionType.receiveTimeout:
  //           return Exception('Connection timeout');
  //         case DioExceptionType.badResponse:
  //           return Exception('Server error: \${error.response?.statusCode}');
  //         case DioExceptionType.connectionError:
  //           return Exception('Network error');
  //         default:
  //           return Exception('Unknown error occurred');
  //       }
  //     }
  //     return Exception('Unexpected error: \$error');
  //   }
  // }
  // ''';

  //     await file.writeAsString(content);
  //   }

  Future<void> _generateRepository(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File(
      '${basePath.path}/domain/repositories/${featureName}_remote_repository.dart',
    );

    final content =
        '''
import 'package:varosa_tech/core/domain/remote_repository.dart';
import 'package:varosa_tech/features/$featureName/domain/entities/$featureName.dart';

abstract class ${className}Repository extends RemoteRepository<$className>{}
''';

    await file.writeAsString(content);
  }

  Future<void> _generateUseCase(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File(
      '${basePath.path}/domain/usecases/get_${featureName}s_usecases.dart',
    );

    final content =
        '''
import 'package:fpdart/fpdart.dart';
import 'package:varosa_tech/core/error/exceptions.dart';
import 'package:varosa_tech/core/usecases/usecase.dart';
import 'package:varosa_tech/features/$featureName/domain/entities/$featureName.dart';
import 'package:varosa_tech/features/$featureName/domain/repositories/${featureName}_remote_repository.dart';

class Get${className}s
    implements ParamLessUseCase<Either<CustomException, List<$className>>> {
  final ${className}Repository repository;

  Get${className}s(this.repository);

  @override
  Future<Either<CustomException, List<$className>>> call() => repository.getAll();
}

class Get${className}ById implements UseCase<Either<CustomException, $className>, String> {
  final ${className}Repository repository;

  Get${className}ById(this.repository);

  @override
  Future<Either<CustomException, $className>> call(String id) => repository.get(id);
}

class Create$className implements UseCase<Either<CustomException, $className>, $className> {
  final ${className}Repository repository;

  Create$className(this.repository);

  @override
  Future<Either<CustomException, $className>> call($className $featureName) =>
      repository.create($featureName);
}

class Update$className implements UseCase<Either<CustomException, $className>, $className> {
  final ${className}Repository repository;

  Update$className(this.repository);

  @override
  Future<Either<CustomException, $className>> call($className $featureName) =>
      repository.update($featureName);
}

class Delete$className implements UseCase<Either<CustomException, $className>, String> {
  final ${className}Repository repository;

  Delete$className(this.repository);

  @override
  Future<Either<CustomException, $className>> call(String id) =>
      repository.delete(id);
}
''';

    await file.writeAsString(content);
  }

  Future<void> _generateBlocEvent(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File(
      '${basePath.path}/presentation/blocs/$featureName/${featureName}_event.dart',
    );

    final content =
        '''
part of '${featureName}_bloc.dart';

sealed class ${className}Event extends Equatable {
  const ${className}Event();

  @override
  List<Object> get props => [];
}

class Load${className}s extends ${className}Event {}

class Load${className}ById extends ${className}Event {
  final String id;

  const Load${className}ById({required this.id});

  @override
  List<Object> get props => [id];
}

class Create${className}Event extends ${className}Event {
  final $className $featureName;

  const Create${className}Event({required this.$featureName});

  @override
  List<Object> get props => [$featureName];
}

class Update${className}Event extends ${className}Event {
  final String id;
  final $className $featureName;

  const Update${className}Event({required this.id, required this.$featureName});

  @override
  List<Object> get props => [id, $featureName];
}

class Delete${className}Event extends ${className}Event {
  final String id;

  const Delete${className}Event({required this.id});

  @override
  List<Object> get props => [id];
}

class Refresh${className}s extends ${className}Event {}
''';

    await file.writeAsString(content);
  }

  Future<void> _generateBlocState(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File(
      '${basePath.path}/presentation/blocs/$featureName/${featureName}_state.dart',
    );

    final content =
        '''
part of '${featureName}_bloc.dart';

sealed class ${className}State extends Equatable {
  const ${className}State();

  @override
  List<Object?> get props => [];
}

class ${className}Initial extends ${className}State {}

class ${className}Loading extends ${className}State {}

class ${className}sLoaded extends ${className}State {
  final List<$className> ${featureName}s;

  const ${className}sLoaded({required this.${featureName}s});

  @override
  List<Object> get props => [${featureName}s];
}

class ${className}Loaded extends ${className}State {
  final $className $featureName;

  const ${className}Loaded({required this.$featureName});

  @override
  List<Object> get props => [$featureName];
}

class ${className}Error extends ${className}State {
  final String message;

  const ${className}Error({required this.message});

  @override
  List<Object> get props => [message];
}

class ${className}OperationSuccess extends ${className}State {
  final String message;

  const ${className}OperationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

''';

    await file.writeAsString(content);
  }

  Future<void> _generateBloc(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File(
      '${basePath.path}/presentation/blocs/$featureName/${featureName}_bloc.dart',
    );

    final content =
        '''
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varosa_tech/features/$featureName/domain/entities/$featureName.dart';
import 'package:varosa_tech/features/$featureName/domain/usecases/get_${featureName}s_usecases.dart';

part '${featureName}_event.dart';
part '${featureName}_state.dart';

class ${className}Bloc extends Bloc<${className}Event, ${className}State> {
  final Get${className}s get${className}s;
  final Get${className}ById get${className}ById;
  final Create$className create$className;
  final Update$className update$className;
  final Delete$className delete$className;

  ${className}Bloc({
    required this.get${className}s,
    required this.get${className}ById,
    required this.create$className,
    required this.update$className,
    required this.delete$className,
  }) : super(${className}Initial()) {
    on<Load${className}s>(_onLoad${className}s);
    on<Load${className}ById>(_onLoad${className}ById);
    on<Create${className}Event>(_onCreate$className);
    on<Update${className}Event>(_onUpdate$className);
    on<Delete${className}Event>(_onDelete$className);
    on<Refresh${className}s>(_onRefresh${className}s);
  }

  Future<void> _onLoad${className}s(Load${className}s event, Emitter<${className}State> emit) async {
    emit(${className}Loading());

    final result = await get${className}s();
    // result.fold(ShowToast.error, (${featureName}s) => emit(${className}sLoaded(${featureName}s: ${featureName}s)));
    result.fold(
      (error) => emit(${className}Error(message: error.message)),
      (${featureName}s) => emit(${className}sLoaded(${featureName}s: ${featureName}s)),
    );

    emit(const ${className}OperationSuccess(message: '${className}s fetched successfully'));
  }

  Future<void> _onLoad${className}ById(
    Load${className}ById event,
    Emitter<${className}State> emit,
  ) async {
    emit(${className}Loading());

    final result = await get${className}ById(event.id);

    result.fold(
      (error) => emit(${className}Error(message: error.message)),
      ($featureName) => emit(${className}Loaded($featureName: $featureName)),
    );

    emit(const ${className}OperationSuccess(message: '$className fetched successfully'));
  }

  Future<void> _onCreate$className(
    Create${className}Event event,
    Emitter<${className}State> emit,
  ) async {
    emit(${className}Loading());

    final result = await create$className(event.$featureName);

    result.fold(
      (error) => emit(${className}Error(message: error.message)),
      ($featureName) => emit(${className}Loaded($featureName: $featureName)),
    );

    emit(const ${className}OperationSuccess(message: '$className created successfully'));
  }

  Future<void> _onUpdate$className(
    Update${className}Event event,
    Emitter<${className}State> emit,
  ) async {
    emit(${className}Loading());

    final result = await update$className(event.$featureName);
    result.fold(
      (error) => emit(${className}Error(message: error.message)),
      ($featureName) => emit(${className}Loaded($featureName: $featureName)),
    );

    emit(const ${className}OperationSuccess(message: '$className updated successfully'));
  }

  Future<void> _onDelete$className(
    Delete${className}Event event,
    Emitter<${className}State> emit,
  ) async {
    emit(${className}Loading());

    final result = await delete$className(event.id);
    result.fold(
      (error) => emit(${className}Error(message: error.message)),
      ($featureName) => emit(${className}Loaded($featureName: $featureName)),
    );

    emit(const ${className}OperationSuccess(message: '$className deleted successfully'));
  }

  Future<void> _onRefresh${className}s(
    Refresh${className}s event,
    Emitter<${className}State> emit,
  ) async {
    add(Load${className}s());
  }
}
''';

    await file.writeAsString(content);
  }

  Future<void> _generateScreen(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File(
      '${basePath.path}/presentation/screens/${featureName}_screen.dart',
    );

    final content =
        '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varosa_tech/features/$featureName/presentation/blocs/$featureName/${featureName}_bloc.dart';
import 'package:varosa_tech/features/$featureName/presentation/widgets/${featureName}_list.dart';


class ${className}Screen extends StatefulWidget {
  const ${className}Screen({super.key});

  @override
  State<${className}Screen> createState() => _${className}ScreenState();
}

class _${className}ScreenState extends State<${className}Screen> {
  @override
  void initState() {
    super.initState();
    context.read<${className}Bloc>().add(Load${className}s());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${className}s'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<${className}Bloc>().add(Refresh${className}s());
            },
          ),
        ],
      ),
      body: BlocConsumer<${className}Bloc, ${className}State>(
        listenWhen: (prev, curr) =>
            curr is ${className}OperationSuccess || curr is ${className}Error,
        listener: (context, state) {
          if (state is ${className}Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ${className}OperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            // Refresh the list after successful operation
            context.read<${className}Bloc>().add(Load${className}s());
          }
        },
        buildWhen: (prev, curr) =>
            !(curr is ${className}OperationSuccess || curr is ${className}Error),
        builder: (context, state) {
          if (state is ${className}Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ${className}sLoaded) {
            return ${className}List(${featureName}s: state.${featureName}s);
          } else if (state is ${className}Error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading ${featureName}s',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<${className}Bloc>().add(Load${className}s());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Welcome to ${className}s'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add/create $featureName screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
''';

    await file.writeAsString(content);
  }

  Future<void> _generateWidgets(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File(
      '${basePath.path}/presentation/widgets/${featureName}_list.dart',
    );

    final content =
        '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varosa_tech/features/$featureName/domain/entities/$featureName.dart';
import 'package:varosa_tech/features/$featureName/presentation/blocs/$featureName/${featureName}_bloc.dart';
import 'package:varosa_tech/features/$featureName/presentation/widgets/${featureName}_item.dart';



class ${className}List extends StatelessWidget {
  final List<$className> ${featureName}s;

  const ${className}List({
    super.key,
    required this.${featureName}s,
  });

  @override
  Widget build(BuildContext context) {
    if (${featureName}s.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No ${featureName}s found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Start by adding your first $featureName',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<${className}Bloc>().add(Refresh${className}s());
      },
      child: ListView.builder(
        itemCount: ${featureName}s.length,
        itemBuilder: (context, index) {
          return ${className}Item(
            $featureName: ${featureName}s[index],
            onTap: () {
              // TODO: Navigate to $featureName detail screen
            },
            onEdit: () {
              // TODO: Navigate to edit $featureName screen
            },
            onDelete: () {
              _showDeleteConfirmation(context, ${featureName}s[index]);
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, $className $featureName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete $className'),
          content: Text('Are you sure you want to delete this $featureName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<${className}Bloc>().add(
                  Delete${className}Event(id: $featureName.id.toString()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
''';

    await file.writeAsString(content);

    // Generate item widget
    await _generateItemWidget(basePath);
  }

  Future<void> _generateItemWidget(Directory basePath) async {
    final className = _toPascalCase(featureName);
    final file = File(
      '${basePath.path}/presentation/widgets/${featureName}_item.dart',
    );

    final content =
        '''
import 'package:flutter/material.dart';
import 'package:varosa_tech/features/$featureName/domain/entities/$featureName.dart';


class ${className}Item extends StatelessWidget {
  final $className $featureName;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ${className}Item({
    super.key,
    required this.$featureName,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(
          $featureName.id,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Id: \${$featureName.id}'),
Text('Message: \${$featureName.message}'),
Text('Sender: \${$featureName.sender}'),

          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit?.call();
                break;
              case 'delete':
                onDelete?.call();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';

    await file.writeAsString(content);
  }

  String _getDisplayField() {
    // Try to find a 'name' field first, then 'title', then use the first string field
    final nameField = dataFields
        .where((f) => f.name.toLowerCase() == 'name')
        .firstOrNull;
    if (nameField != null) return '$featureName.${nameField.name}';

    final titleField = dataFields
        .where((f) => f.name.toLowerCase() == 'title')
        .firstOrNull;
    if (titleField != null) return '$featureName.${titleField.name}';

    final stringField = dataFields
        .where((f) => f.type.toLowerCase() == 'string')
        .firstOrNull;
    if (stringField != null) return '$featureName.${stringField.name}';

    // Fallback to first field
    return '$featureName.${dataFields.first.name}.toString()';
  }

  String _generateSubtitleFields() {
    final buffer = StringBuffer();
    final displayFields = dataFields
        .take(3)
        .where(
          (f) =>
              f.name.toLowerCase() != 'name' && f.name.toLowerCase() != 'title',
        );

    for (final field in displayFields) {
      buffer.writeln(
        'Text(\'${_toTitleCase(field.name)}: \${$featureName.${field.name}}\'),',
      );
    }

    if (buffer.isEmpty) {
      buffer.writeln(
        'Text(\'ID: \${$featureName.${dataFields.first.name}}\'),',
      );
    }

    return buffer.toString();
  }

  String _getFromJsonConversion(DataField field, String jsonKey) {
    if (field.isOptional) {
      switch (field.type.toLowerCase()) {
        case 'int':
          return "json['$jsonKey'] as int?";
        case 'double':
          return "json['$jsonKey']?.toDouble()";
        case 'bool':
          return "json['$jsonKey'] as bool?";
        case 'string':
          return "json['$jsonKey'] as String?";
        default:
          return "json['$jsonKey'] != null ? ${field.type}.fromJson(json['$jsonKey']) : null";
      }
    } else {
      switch (field.type.toLowerCase()) {
        case 'int':
          return "json['$jsonKey'] as int";
        case 'double':
          return "(json['$jsonKey'] as num).toDouble()";
        case 'bool':
          return "json['$jsonKey'] as bool";
        case 'string':
          return "json['$jsonKey'] as String";
        default:
          return "${field.type}.fromJson(json['$jsonKey'])";
      }
    }
  }

  String _getToJsonConversion(DataField field) {
    if (field.type.toLowerCase() == 'string' ||
        field.type.toLowerCase() == 'int' ||
        field.type.toLowerCase() == 'double' ||
        field.type.toLowerCase() == 'bool') {
      return field.name;
    } else {
      return field.isOptional
          ? '${field.name}?.toJson()'
          : '${field.name}.toJson()';
    }
  }

  String _getFromMapConversion(DataField field) {
    if (field.isOptional) {
      switch (field.type.toLowerCase()) {
        case 'int':
          return "map['${field.name}'] as int?";
        case 'double':
          return "map['${field.name}']?.toDouble()";
        case 'bool':
          return "map['${field.name}'] as bool?";
        case 'string':
          return "map['${field.name}'] as String?";
        default:
          return "map['${field.name}'] != null ? ${field.type}.fromMap(map['${field.name}']) : null";
      }
    } else {
      switch (field.type.toLowerCase()) {
        case 'int':
          return "map['${field.name}'] as int";
        case 'double':
          return "(map['${field.name}'] as num).toDouble()";
        case 'bool':
          return "map['${field.name}'] as bool";
        case 'string':
          return "map['${field.name}'] as String";
        default:
          return "${field.type}.fromMap(map['${field.name}'])";
      }
    }
  }

  String _toPascalCase(String input) {
    return input
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join();
  }

  String _toSnakeCase(String input) {
    return input
        .replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) => '_${match.group(0)!.toLowerCase()}',
        )
        .replaceFirst(RegExp(r'^_'), '');
  }

  String _toTitleCase(String input) {
    return input
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  Future<void> _printDirectoryTree(Directory dir, String prefix) async {
    final entities = await dir.list().toList();
    entities.sort((a, b) => a.path.compareTo(b.path));

    for (int i = 0; i < entities.length; i++) {
      final entity = entities[i];
      final isLast = i == entities.length - 1;
      final name = entity.path.split('/').last;

      if (entity is Directory) {
        print('$prefix${isLast ? '└── ' : '├── '}$name/');
        final newPrefix = prefix + (isLast ? '    ' : '│   ');
        await _printDirectoryTree(entity, newPrefix);
      } else {
        print('$prefix${isLast ? '└── ' : '├── '}$name');
      }
    }
  }
}

class DataField {
  final String name;
  final String type;
  final bool isOptional;

  DataField(this.name, this.type, this.isOptional);
}

extension ListExtension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
