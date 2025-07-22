# Modular Dependency Injection Architecture

This project implements a modular dependency injection system that promotes maintainability, testability, and scalability.

## Architecture Overview

### Core DI Framework
- **`core/di/feature_di.dart`**: Provides base interfaces and helpers for feature modules
- **`core/service_locator.dart`**: Main service locator that orchestrates all feature modules

### Feature Modules
Each feature module has its own self-contained DI configuration:
- **`apps/mini_ecommerce/di/ecommerce_di.dart`**: Mini ecommerce feature dependencies

## Key Benefits

### 🧩 **Modularity**
- Each feature manages its own dependencies
- Easy to add/remove features without affecting others
- Clear separation of concerns

### 🔧 **Maintainability**
- Dependencies are co-located with their features
- Reduced coupling between modules
- Easier to understand and modify

### 🧪 **Testability**
- Each feature can be tested in isolation
- Easy to mock dependencies for specific features
- Support for dependency unregistration

### 📈 **Scalability**
- New features can follow the same pattern
- No risk of dependency conflicts
- Clean architecture enforcement

## Usage

### Adding a New Feature Module

1. Create your feature DI class:
```dart
class MyFeatureDI with DIHelpers implements FeatureDI {
  @override
  void registerDependencies(GetIt sl) {
    // Register your dependencies
  }

  @override
  void unregisterDependencies(GetIt sl) {
    // Unregister your dependencies
  }

  // Static convenience methods
  static void register(GetIt sl) {
    final instance = MyFeatureDI();
    instance.registerDependencies(sl);
  }
}
```

2. Register in main service locator:
```dart
// In core/service_locator.dart
MyFeatureDI.register(sl);
```

### Safety Features

The `DIHelpers` mixin provides safe registration methods:
- `safeRegister<T>()`: Only registers if not already registered
- `safeRegisterFactory<T>()`: Safe factory registration
- `safeUnregister<T>()`: Safe unregistration

### Example: Mini Ecommerce Module

```dart
// Registration
EcommerceDI.register(sl);

// Unregistration (for testing)
EcommerceDI.unregister(sl);
```

## File Structure

```
lib/
├── core/
│   ├── di/
│   │   └── feature_di.dart          # Base DI interfaces
│   └── service_locator.dart         # Main orchestrator
└── apps/
    └── mini_ecommerce/
        └── di/
            └── ecommerce_di.dart    # Feature-specific DI
```

## Best Practices

1. **Keep dependencies co-located** with their features
2. **Use the safety helpers** to prevent registration conflicts
3. **Implement both registration and unregistration** for testability
4. **Follow the established patterns** for consistency
5. **Document feature-specific dependencies** in their respective DI files

This architecture ensures that as your project grows, dependency management remains clean, maintainable, and scalable! 🚀
