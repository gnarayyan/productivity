# Flutter Feature Generator

A comprehensive Dart script that generates clean architecture feature structures with boilerplate code for Flutter applications.

## Features

- 🏗️ **Clean Architecture**: Generates complete feature structure following clean architecture principles
- 📁 **Organized Structure**: Creates data, domain, and presentation layers
- 🔧 **Boilerplate Code**: Auto-generates entities, models, repositories, use cases, BLoCs, and widgets
- 📝 **Custom Fields**: Define your own data fields with types
- 🔄 **JSON Support**: Optional fromJson/toJson method generation
- 🎯 **Smart Conventions**: Follows Flutter and Dart naming conventions

## Usage

### Quick Start

```bash
# Make the script executable (first time only)
chmod +x cmd/generate_feature.dart

# Run the generator
dart run cmd/generate_feature.dart
```

### Interactive Setup

The generator will ask you several questions:

1. **Feature Name**: Enter in snake_case (e.g., `user_profile`, `product_catalog`)
2. **Feature Path**: Where to create the feature (default: `lib/features/<feature_name>`)
3. **Data Fields**: Define your entity fields with types
4. **JSON Generation**: Whether to generate fromJson/toJson methods

### Example Workflow

```
🚀 Flutter Feature Generator - Clean Architecture
==================================================

Enter feature name: product
Path to put feature (default: lib/features/product):
Enter data fields (e.g., id:int name:string price:double author?:User): id:int name:string price:double category:string description?:string
Generate fromJson/toJson methods? (y/N): y

📋 Summary:
   Feature: product
   Path: lib/features/product
   Fields: id:int, name:string, price:double, category:string, description?:string
   JSON methods: Yes

Proceed? (Y/n): y
```

## Generated Structure

```
lib/features/product/
├── data/
│   ├── datasources/
│   │   └── product_remote_data_source.dart
│   ├── models/
│   │   └── product_model.dart
│   ├── repositories/
│   │   └── product_repository_impl.dart
│   └── services/
│       └── api_service.dart
├── domain/
│   ├── entities/
│   │   └── product.dart
│   ├── repositories/
│   │   └── product_repository.dart
│   └── usecases/
│       └── get_products.dart
└── presentation/
    ├── blocs/
    │   └── product/
    │       ├── product_bloc.dart
    │       ├── product_event.dart
    │       └── product_state.dart
    ├── screens/
    │   └── product_screen.dart
    └── widgets/
        ├── product_list.dart
        └── product_item.dart
```

## Field Types

### Supported Basic Types

- `int` - Integer numbers
- `double` - Decimal numbers
- `string` - Text strings
- `bool` - Boolean values

### Complex Types

- `User` - Custom object types
- `DateTime` - Date and time
- Any custom class name

### Optional Fields

Add `?` after field name to make it optional:

```
id:int name:string email?:string age?:int
```

## Generated Code Features

### Entity Class

- 🔧 **Equatable**: Proper equality comparison
- 📝 **toString**: Readable string representation
- 📋 **Immutable**: All fields are final

### Model Class

- 🔄 **copyWith**: Create modified copies
- 📤 **toJson/fromJson**: JSON serialization (optional)
- 🗃️ **toMap/fromMap**: Map conversion
- 🏗️ **fromEntity**: Convert from domain entity

### Repository Pattern

- 🎯 **Abstract Interface**: Clean separation of concerns
- 🔧 **Concrete Implementation**: Complete CRUD operations
- ⚠️ **Error Handling**: Proper exception mapping

### BLoC Pattern

- 📨 **Events**: All CRUD events
- 🏛️ **States**: Loading, success, error states
- 🎯 **Logic**: Complete business logic implementation

### UI Components

- 📱 **Screen**: Complete list screen with error handling
- 🧩 **Widgets**: Reusable list and item widgets
- 🔄 **Refresh**: Pull-to-refresh functionality

## Dependencies

The generator creates code that uses these packages:

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  dio: ^5.3.2

dev_dependencies:
  flutter_test:
    sdk: flutter
```

## Next Steps After Generation

1. **Add Dependencies**: Add required packages to `pubspec.yaml`
2. **Register Services**: Set up dependency injection
3. **Connect Routes**: Add navigation to your app router
4. **Customize UI**: Modify the generated widgets to match your design
5. **Add Tests**: Write unit tests for your feature

## Advanced Usage

### Custom Templates

The generator can be modified to use your own code templates by editing the generation methods in the script.

### Integration with Existing Projects

The generator respects existing project structure and won't overwrite existing files.

## Troubleshooting

### Common Issues

1. **Feature name validation**: Use snake_case only
2. **Path permissions**: Ensure write permissions for target directory
3. **Existing files**: Generator won't overwrite existing files

### Getting Help

If you encounter issues:

1. Check the console output for specific error messages
2. Ensure proper field syntax: `fieldName:Type`
3. Verify write permissions for the target directory

## Contributing

To improve the generator:

1. Fork the repository
2. Modify the `cmd/generate_feature.dart` script
3. Test with different feature configurations
4. Submit a pull request

## License

This tool is part of the Flutter Productivity App project and follows the same license terms.
