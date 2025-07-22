# varosa\_tech

A new Flutter project for the evaluation exam at Varosa Technology.

---

**You can try out android application at:** /release/app-release.apk

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


## 5. `nested_bottom_nav`

### 📋 Requirements

- To build Flutter application that uses a bottom navigation bar with 3 items:
Item 1, Item 2, and Item 3.
- Each item displays a screen with a button for navigation. When the button is pressed, a new
screen is pushed (navigated to). However:
1. The bottom navigation bar must remain visible on the new screen.​
2. The user must still be able to switch between Item 1, Item 2, and Item 3 even after
navigating.​
3. The navigation must be nested, such that pressing the button does not navigate away
from the home layout but pushes a screen within the respective tab.
🔹 Implement this using nested navigation, ensuring each tab maintains its own navigation
stack independently.

Sample Screens:
Screen1:
      Item1 Screen
       Button(clickable)
       -> Pushes item1 detail screen

    BtnNav1  BtnNav2  BtnNav3   

Screen2:
      Item1 Deatail Screen

    BtnNav1  BtnNav2  BtnNav3   

---

### 🧠 Thought Process

**Example analogy to understand**
1. User taps Item1 → sees "Item1 Screen" with a button.
2. Presses button → "Item1 Detail Screen" is pushed.
3. Bottom bar is still visible.
4. Switch to Item2 → shows "Item2 Screen".
5. Return to Item1 → still on "Item1 Detail Screen".

**Technical analysis**
- Each tab has its own `Navigator` widget with independent navigation stack
- `IndexedStack` preserves state when switching between tabs
- Bottom navigation bar remains persistent across all navigation levels
- Custom tab navigator handles route management within each tab
- BLoC manages the selected tab state globally

**Verdict**
-  Bottom bar remains visible on all screens
-  Each tab maintains its own navigation history
-  Proper nesting within tab navigators, not global navigation
-  Tab states are preserved when switching between tabs
-  Material 3 design with consistent theming and smooth transitions
-  Support for multiple levels of navigation within each tab
- Clean state management for tab selection
- Implment 3 level deep detail screen, also we can scroll a view inside 1st page to ensure its not freshly build

### 📦 No extra dependencies Added
- Uses built-in Navigator widgets for nested navigation
- BLoC for state management (already included)
- Material 3 design system

### 🏗️ Architecture Highlights

#### **Navigation Architecture:**
1. **Main Scaffold**: Contains IndexedStack and persistent bottom navigation
2. **Tab Navigators**: Each tab has its own Navigator widget with independent routing
3. **State Management**: BLoC manages selected tab index globally
4. **Route Management**: Custom route generation within each tab's Navigator

#### **Key Features:**
- **Persistent Bottom Bar**: Remains visible throughout all navigation levels
- **Independent Stacks**: Each tab maintains its own navigation history
- **State Preservation**: Tab content is preserved when switching between tabs
- **Deep Navigation**: Support for multiple nested screens within each tab
- **Smooth Transitions**: Beautiful Material 3 transitions and animations

### 📂 Folder Structure

```bash
lib/
├── apps/
│   └── nested_bottom_nav/
│       ├── bloc/
│       │   ├── navigation_bloc.dart      # Tab selection state management
│       │   ├── navigation_event.dart     # Tab change events
│       │   └── navigation_state.dart     # Navigation state definition
│       ├── pages/
│       │   └── nested_bottom_nav_page.dart  # Main page with bottom navigation
│       └── widgets/
│           ├── tab_navigator.dart        # Individual tab navigator
│           ├── tab_home_screen.dart      # Home screen for each tab
│           └── tab_detail_screen.dart    # Detail screen with deep navigation
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

# `refresh_token_auth`

### 📋 Requirements

* **Evaluation Focus:**

  * Authentication flow
  * Token management
  * State persistence
  * Error handling

### ✅ Tasks

* Implement comprehensive refresh token authentication system
* Handle automatic token refresh on API failures
* Manage authentication state with BLoC
* Store tokens securely using SharedPreferences
* Provide login/logout functionality with beautiful UI

### 🧠 Thought Process


* **Proactive Refresh**: Automatically refresh tokens before they expire
* **Reactive Refresh**: Handle 401 responses and retry failed requests
* **Concurrency Control**: Prevent multiple refresh attempts simultaneously
* **State Management**: Track authentication status across the app
* **Error Handling**: Graceful fallbacks when refresh fails

### 📦 Dependencies Added

```yaml
# HTTP & Storage
dio:                   # HTTP client with interceptors
shared_preferences:    # Secure token storage

# State Management (already included)
flutter_bloc:          # Authentication state management
equatable:             # Value equality for states
```

### 🏗️ Architecture Highlights

#### **Clean Architecture Pattern:**
1. **Domain Layer**: Authentication entities and repository contracts
2. **Data Layer**: Local storage, API integration, and repository implementations
3. **Presentation Layer**: BLoC state management and authentication UI

#### **Token Refresh Strategy:**
- **Proactive**: Refresh tokens 5 minutes before expiration
- **Reactive**: Automatic retry with fresh tokens on 401 responses
- **Transparent**: Users never see authentication errors during auto-refresh

#### **Key Features:**
- **Dio Interceptor**: Automatically adds auth headers and handles 401s
- **Concurrency Safe**: Prevents multiple simultaneous refresh operations
- **State Persistence**: Remember login state across app restarts
- **Beautiful UI**: Material 3 login form with validation and loading states
- **Token Management**: Display token status, expiry, and manual refresh options

### �� Folder Structure

```bash
lib/
├── core/
│   └── auth/
│       ├── models/
│       │   ├── auth_tokens.dart          # Token model with validation
│       │   └── user.dart                 # User profile model
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── auth_local_data_source.dart    # SharedPreferences storage
│       │   │   └── auth_remote_data_source.dart   # Mock API calls
│       │   └── repositories/
│       │       └── auth_repository_impl.dart      # Repository implementation
│       ├── domain/
│       │   └── repositories/
│       │       └── auth_repository.dart           # Repository contract
│       ├── services/
│       │   └── token_refresh_service.dart         # Automatic token refresh
│       ├── bloc/
│       │   ├── auth_bloc.dart            # Authentication state management
│       │   ├── auth_event.dart           # Authentication events
│       │   └── auth_state.dart           # Authentication states
│       ├── widgets/
│       │   ├── login_form.dart           # Beautiful login form
│       │   └── authenticated_dashboard.dart       # Token status dashboard
│       └── pages/
│           └── auth_demo_page.dart       # Main auth demonstration page
```

### 🔧 How It Works

#### **Login Flow:**
1. User enters credentials → Form validation
2. API call with loading state → Mock authentication
3. Store tokens securely → Update authentication state
4. Start proactive refresh timer → Navigate to dashboard

#### **Automatic Token Refresh:**
1. **Proactive**: Timer triggers refresh 5 minutes before expiration
2. **Reactive**: Any API call gets 401 → Automatically refresh → Retry original request
3. **Concurrency**: Multiple requests wait for single refresh operation
4. **Failure**: If refresh fails → Logout user gracefully

#### **Dashboard Features:**
- **User Profile**: Display authenticated user information
- **Token Status**: Show access token, refresh token, and expiry times
- **Manual Actions**: Force token refresh or logout
- **Copy Tokens**: Tap to copy tokens to clipboard for inspection

#### **State Management:**
```dart
// Authentication states
AuthInitial()           // App starting up
AuthLoading()          // Processing login/refresh
AuthAuthenticated()    // User logged in with valid tokens
AuthUnauthenticated()  // User logged out or tokens expired
AuthError()           // Authentication failed
```

This system provides a **complete authentication foundation** that can be easily integrated into any Flutter app requiring secure API access with automatic token management! 🔐

---

# 🚀 How It All Works Together

## 📱 **The App Experience**

When you run this app, you'll see a **beautiful landing page** with cards for each of the 6 demonstration apps. Each app showcases different Flutter concepts and architectures:

### 🏠 **Landing Page**
- **Modern UI**: Material 3 design with gradient cards and smooth animations
- **Easy Navigation**: Tap any card to explore a specific app
- **Coming Soon**: Some advanced features show elegant "coming soon" dialogs

### 🔄 **Navigation Flow**
```
Landing Page
    ├── 📝 Offline Todo (BLoC + SQLite)
    ├── 📱 Method Channel (Native Integration)
    ├── 📋 Dynamic Form (JSON Parsing)
    ├── 🛒 Mini Ecommerce (Clean Architecture)
    ├── 🧭 Nested Navigation (Complex Navigation)
    └── 🔐 Refresh Token Auth (Authentication)
```

## 🏗️ **Architecture Philosophy**

### **Different Patterns for Different Needs**
Each app intentionally uses **different architectural patterns** to demonstrate various approaches:

- **Todo App**: Traditional layered architecture with BLoC
- **Method Channel**: Simple MVVM pattern for native integration
- **Dynamic Form**: State-driven architecture for complex forms
- **Ecommerce**: Clean architecture with strict separation of concerns
- **Navigation**: Nested navigator pattern for complex UI flows
- **Authentication**: Repository pattern with interceptors and services

### **Shared Foundation**
While each app has its own pattern, they all share:
- **Dependency Injection**: GetIt service locator
- **Routing**: Auto Route for navigation
- **Theming**: Consistent Material 3 design system
- **State Management**: BLoC pattern throughout

## 🎯 **Key Demonstrations**

### **1. State Management Mastery**
- **BLoC Pattern**: Used across all apps for predictable state management
- **Event-Driven**: Clear separation between UI events and business logic
- **Reactive Programming**: Stream-based architecture for real-time updates

### **2. Data Persistence**
- **SQLite**: Local database for todos and favorites
- **SharedPreferences**: Simple key-value storage for settings and tokens
- **In-Memory**: Temporary state for forms and navigation

### **3. Network Integration**
- **REST APIs**: Fetch products from real APIs
- **Error Handling**: Comprehensive error states and retry mechanisms
- **Caching**: Smart image caching and data persistence

### **4. Native Platform Features**
- **MethodChannel**: Bridge between Flutter and native code
- **Platform Views**: Embed native UI components
- **Device APIs**: Access battery, device info, and system features

### **5. Complex UI Patterns**
- **Nested Navigation**: Independent navigation stacks per tab
- **Dynamic Forms**: Build UI from JSON configuration
- **Infinite Scroll**: Lazy loading with pagination
- **Authentication Flows**: Login, token refresh, and logout







