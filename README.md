# varosa\_tech

A new Flutter project for the evaluation exam at Varosa Technology.

---

## 🧠 Initial Thought

* Instead of building 5 separate apps, I'll develop a single app with a home screen to navigate to each of the 5 apps.
  This will:

  * Save time (no need to create multiple projects or install dependencies repeatedly).
  * Help the evaluator inspect a **single codebase** and **app structure**.

* First, I'll make the app compatible with Android, then test and adapt it for iOS.

* If time permits, I'll work on extras like themes, polish, etc.

### 📁 Folder Structure

```bash
lib/
  apps/
    offline_todo/
    dynamic_form/
    mini_ecommerce/
    method_channel/
    nested_bottom_nav/
  themes/
  core/
  common/
```

Each app will have its **own architecture and pattern** (to meet evaluation requirements).
Common logic (themes, components, helpers) will be shared via the `core`, `themes`, or `common` directories.

⚠️ Note: This reusability might seem like an anti-pattern, but I'm intentionally taking this liberty for efficiency.

---

## 🧪 Development Environment

* **Flutter:** 3.32.7
* **Dart:** 3.8.1
* **OS:** Ubuntu 24.04.2 LTS
* **IDE:** VS Code
* **Later:** Use macOS for iOS compatibility

---

# 🧩 Apps Overview

---

## 1. `offline_todo`

### 📋 Requirements

* **Evaluation Focus:**

  * State management
  * Architecture
  * Local storage using SQLite
  * Async handling

### ✅ Tasks

* Add, update, and delete to-dos
* Persist to-dos using SQLite
* Use BLoC for UI state management
* *(Optional)* Firebase sync

### 🧠 Thought Process

To-do is a simple CRUD app, so instead of using feature-first structure, I’ll follow a **"layer-first"** approach.

### 📦 Dependencies (to be adjusted)

**State Management**

```yaml
flutter_bloc: ^9.1.1
equatable: ^2.0.7
```

**Local Storage**

```yaml
sqflite: ^2.4.2
path: ^1.9.1
```

**UI & Utilities**

```yaml
cupertino_icons: ^1.0.8
google_fonts: ^6.2.1
lucide_icons: ^0.257.0
get_it: ^8.0.3
auto_route: ^10.1.0+1
```

**Dev Dependencies**

```yaml
flutter_lints: ^5.0.0
auto_route_generator: ^10.2.3
build_runner: ^2.5.4
```

---

### 📂 Folder Structure

```bash
lib/
├── apps/
│   └── offline_todo/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── local_datasource.dart
│       │   ├── models/
│       │   │   └── todo_model.dart
│       │   └── repositories/
│       │       └── todo_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── todo.dart
│       │   ├── repositories/
│       │   │   └── todo_repository.dart
│       │   └── usecases/
│       │       ├── add_todo.dart
│       │       ├── update_todo.dart
│       │       ├── delete_todo.dart
│       │       └── get_todos.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── todo_bloc.dart
│           │   ├── todo_event.dart
│           │   └── todo_state.dart
│           ├── pages/
│           │   ├── todo_list_page.dart
│           │   └── add_edit_todo_page.dart
│           └── widgets/
│               ├── todo_item.dart
│               └── todo_form.dart
├── core/
│   ├── landing_page/
│   │   ├── app_card.dart
│   │   ├── landing_page.dart
│   │   └── show_coming_soon_dialog.dart
│   └── router/
│       ├── app_router.dart
│       └── app_router.gr.dart
├── themes/
│   └── app_theme.dart
└── main.dart
```

---

## 4. `method_channel`

### 📋 Requirements

**1. Use MethodChannel to return a JSON:**

```json
{
  "batteryLevel": 88,
  "deviceModel": "Pixel 6",
  "isCharging": true,
  "systemTime": "2025-06-09T12:30:00Z"
}
```

**2. On Flutter side:**

* Parse the JSON response
* Convert `systemTime` to `DateTime`
* Display all values on UI
* Include a button to fetch & display data

**3. PlatformView:**

* Show a native button
* On press: refresh battery percentage

---

### 🧠 Thought Process

This seems like the simplest app. The real challenge is:

* Implementing `MethodChannel` for:

  * Battery level
  * Device model
  * Charging status
  * System time
  * Native button using PlatformView

---

### ✅ Steps

1. Implement native MethodChannel call
2. Parse response JSON
3. Build and render UI

---

### 📂 Folder Structure

Using an MVVM-inspired structure:

```bash
method_channel/
├── bloc/
│   ├── device_info_bloc.dart
│   ├── device_info_event.dart
│   └── device_info_state.dart
├── models/
│   └── device_info.dart
├── services/
│   └── device_info_service.dart
├── pages/
│   └── method_channel_page.dart
└── widgets/
    ├── device_info_card.dart
    ├── error_card.dart
    ├── info_row.dart
    ├── loading_card.dart
    └── native_button_view.dart
```

---

### 🔧 Enhancements

* Better code structure
* `freezed` for model generation
* BLoC for state management
* iOS compatibility checked

---

## 3. `dynamic_form`

### 📋 Requirements

* **Evaluation Focus:**

  * JSON parsing
  * Dynamic widget building
  * State handling

### ✅ Tasks

* JSON Like data below is given:

```json
Given a JSON like:
{
"form": {
"title": "Car Insurance Application",
"steps": [
{
"title": "Personal Information",
"description": "Enter your basic personal details.",
"inputs": [{
"key": "fullName",
"type": "text",
"label": "Full Name",
"required": true
},
{
"key": "age",
"type": "text",
"label": "Age",
"required": true,
"default": 18,
"validation": {
"numberOnly": true
}
},
{
"key": "gender",
"type": "dropdown",
"label": "Gender",
"options": ["Male", "Female", "Other"],
"required": true
}
]
},
{
"title": "Vehicle Details",
"description": "Provide information about your vehicle.",
"inputs": [
{
"key": "vehicleType",
"type": "dropdown",
"label": "Vehicle Type",​
"default": "Motorbike",
"options": ["Car", "Motorbike", "Truck"],
"required": true
},
{
"key": "vehicleYear",
"type": "text",
"label": "Vehicle Manufacture Year",
"required": true,
"validation": {
"numberOnly": true
}
},
{
"key": "hasExistingInsurance",
"type": "toggle","label": "Do you currently have insurance?",
"default": false,
"required": false
}
]
},
{
"title": "Coverage Preferences",
"description": "Select the type of coverage you prefer.",
"inputs": [
{
"key": "coverageType",
"type": "dropdown",
"label": "Coverage Type",
"options": ["Third-Party", "Comprehensive", "Own Damage Only"],
"required": true
},
{
"key": "roadsideAssistance",
"type": "toggle",
"label": "Include Roadside Assistance?",
"required": false
}
]
},
{
"title": "Review & Submit",
"description": "Review your inputs before submitting the form.",
"inputs": []
}
]
}
}
```
I need to : 
- Render a dynamic multi step form based on this json.​
- Validate and show collected form values on submit.

### 🧠 Thought Process

- I'll use MVVM pattern for it.
- Complex form data so will use freezed and isolate for better performance
- Then I'll implement clean and efficient way to validate form
- After that, I'll show another form preview page
- Bloc & get_it for state management and dependency injection
- Auto Route for routing

**Verdict**
- Freezeed wasn't used, parsing is done manually
- Used isolates but it was very small JSON so using isolates performance dropped from 15ms to avg 350 ms so isolate isn't used

### 📦 No extra dependencies Added





---

### 📂 Folder Structure

```bash
lib/
├── apps/
│   └── dynamic_form/
          - bloc
          - models
          - presentation

├── core/
│   ├── landing_page/
│   │   ├── app_card.dart
│   │   ├── landing_page.dart
│   │   └── show_coming_soon_dialog.dart
│   └── router/
│       ├── app_router.dart
│       └── app_router.gr.dart
├── themes/
│   └── app_theme.dart
└── main.dart
```





## 4. `mini_ecommerce`

### 📋 Requirements

* **Evaluation Focus:**

  * Clean architecture
  * lazy loading
  * modular design
  * image handling.

### ✅ Tasks

- Fetch and display products from a mock API.​
- Show infinite scrolling.​
-​ Add a “favorites” feature with local persistence.​ (Lets use sqflite for that)
- Optional: Add a filter/search bar.​


### 🧠 Thought Process
- I'll use: [fakestoreapi](https://fakestoreapi.com/products) it
- I'll strictly follow clean architecture for it (data, domain, and presentation layers + SOLID Principle).
- For Lazy Loading, i'll use ListView.builder with a scroll controller.
- For infinite scroll, scroll controller will Detect when reaching the bottom and fetch more items.
- For Modular Design, I'll follow feature-first structure, own navigation & DI per feature
- For Image Handling, i'll used cached_network_image package for network image caching and Handle errors and loading placeholders(shimmer).
- Bloc & get_it for state management and dependency injection
- Auto Route for routing

**Verdict**
- ✅ **Clean Architecture**: Strict separation of data, domain, and presentation layers
- ✅ **Modular DI**: Self-contained dependency injection with `FeatureDI` interface
- ✅ **Infinite Scroll**: Lazy loading with scroll controller and pagination
- ✅ **Debounced Search**: 500ms debounce to minimize API calls during typing
- ✅ **Image Optimization**: `cached_network_image` with shimmer loading and error handling
- ✅ **SQLite Favorites**: Local persistence for favorite products
- ✅ **BLoC Pattern**: Separate blocs for products and favorites with proper state management
- ✅ **Responsive UI**: Material 3 design with proper aspect ratios and overflow handling

### 📦 dependencies Added
- dio: ^5.7.0                    # HTTP client for API calls
- cached_network_image: ^3.4.1   # Network image caching
- sqflite: ^2.4.2               # SQLite for favorites persistence

### 🏗️ Architecture Highlights

#### **Clean Architecture Layers:**
1. **Domain Layer**: Pure business logic with entities, repositories, and use cases
2. **Data Layer**: API integration, local storage, and repository implementations  
3. **Presentation Layer**: BLoC state management and UI widgets

#### **Key Features:**
- **Lazy Loading**: Products load in batches of 20 with infinite scroll
- **Search & Filter**: Real-time search with category filtering
- **Favorites System**: Add/remove favorites with SQLite persistence
- **Error Handling**: Comprehensive error states and retry mechanisms
- **Performance**: Debounced search, image caching, and optimized rendering

#### **Modular DI System:**
- `EcommerceDI`: Self-contained dependency injection module
- `FeatureDI`: Base interface for all feature modules
- `DIHelpers`: Safe registration/unregistration utilities
- Clean separation from main service locator





---

### 📂 Folder Structure

```bash
lib/
├── apps/
│   └── mini_ecommerce/
│       ├── di/
│       │   └── ecommerce_di.dart          # Self-contained DI module
│       ├── features/
│       │   └── products/
│       │       ├── data/
│       │       │   ├── datasources/
│       │       │   │   ├── product_remote_data_source.dart
│       │       │   │   └── favorite_local_data_source.dart
│       │       │   └── repositories/
│       │       │       ├── product_repository_impl.dart
│       │       │       └── favorite_repository_impl.dart
│       │       ├── domain/
│       │       │   ├── entities/
│       │       │   │   ├── product.dart
│       │       │   │   ├── rating.dart
│       │       │   │   └── favorite_product.dart
│       │       │   ├── repositories/
│       │       │   │   ├── product_repository.dart
│       │       │   │   └── favorite_repository.dart
│       │       │   └── usecases/
│       │       │       ├── get_products.dart
│       │       │       ├── search_products.dart
│       │       │       ├── get_categories.dart
│       │       │       ├── get_products_by_category.dart
│       │       │       ├── get_favorites.dart
│       │       │       ├── add_to_favorites.dart
│       │       │       ├── remove_from_favorites.dart
│       │       │       └── is_favorite.dart
│       │       └── presentation/
│       │           ├── bloc/
│       │           │   ├── product/
│       │           │   │   ├── product_bloc.dart
│       │           │   │   ├── product_event.dart
│       │           │   │   └── product_state.dart
│       │           │   └── favorite/
│       │           │       ├── favorite_bloc.dart
│       │           │       ├── favorite_event.dart
│       │           │       └── favorite_state.dart
│       │           ├── pages/
│       │           │   └── ecommerce_page.dart
│       │           └── widgets/
│       │               ├── product_grid.dart
│       │               ├── product_card.dart
│       │               ├── search_bar.dart          # Debounced search
│       │               ├── category_filter.dart
│       │               ├── favorites_tab.dart
│       │               ├── favorite_card.dart
│       │               └── loading_shimmer.dart
├── core/
│   ├── di/
│   │   ├── feature_di.dart              # Base DI interfaces & helpers
│   │   └── README.md                    # DI architecture documentation
│   ├── landing_page/
│   │   ├── app_card.dart
│   │   ├── landing_page.dart
│   │   └── show_coming_soon_dialog.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   └── app_router.gr.dart
│   └── service_locator.dart             # Main DI orchestrator
├── themes/
│   └── app_theme.dart
└── main.dart
```





---