# Flutter Productivity App - Frontend

## 1. Overview
A Flutter-based productivity app designed to enhance personal productivity by helping users manage daily activities and finances. It features two core modules—Personal Management and Financial Management—with an offline-first approach, biometric authentication, multi-language support (English and Hindi), and a consistent UI with light and dark themes.

## 2. Core Features

- **Manage Daily Activities**: Set goals, track tasks, and monitor progress
- **Manage Finances**: Track income, expenses, budgets, and investments
- **Habit Tracking**: Track daily habits and build streaks
- **Data Analytics**: Insights and reports on productivity and financial patterns
- **Backup & Restore**: Cloud backup of data with restore functionality
- **Export Features**: Export data to PDF/Excel for external analysis
- **Extensibility**: Placeholder for additional features to be added later

## 3. Tech Stack

### Frontend: Flutter
**Core Packages:**
- **Dio**: HTTP requests
- **Bloc**: State management
- **Sqflite**: Local storage
- **auto_route**: Routing

**Data Packages:**
- **freezed**: Immutable data classes
- **freezed_annotation**: Code generation for freezed
- **json_annotation**: JSON serialization

**UI Packages:**
- **lucide_icons**: Icons
- **cached_network_image**: Image caching
- **flutter_localizations**: Localization
- **fl_chart**: Financial charts and progress visualization

**Authentication:**
- **local_auth**: Biometric authentication
- **flutter_secure_storage**: Secure token storage

**Utilities:**
- **flutter_local_notifications**: Task reminders
- **get_it**: Dependency injection
- **nepali_date_picker**: Nepali calendar support
- **intl**: Internationalization

**Local Database:**
- **Sqflite**: SQLite wrapper for Flutter

## 4. App Architecture

- **Modular Design**: Separate modules for Personal Management, Financial Management, Authentication, and Settings
- **Offline-First**: All data is stored locally using Sqflite and synced with the backend when online
- **State Management**: Bloc pattern for managing app state
- **Routing**: auto_route for navigation between screens
- **Dependency Injection**: get_it for managing dependencies
- **API Communication**: Dio for HTTP requests to the backend
- **Data Models**: Immutable classes using freezed for type safety and serialization

## 5. Modules and Features

### 5.1 Authentication Module

**Features:**
- User login and registration via email/password
- Biometric authentication (fingerprint/face recognition) for secure access

**Screens:**
- Login Screen: Email/password input and biometric option
- Register Screen: Form for account creation
- Biometric Setup Screen: Enable biometric login

### 5.2 Personal Management Module

**Features:**
- **Goal Categories**: Users can create categories (e.g., Health, Work, Hobby, Learning)
- **Goal Creation**: 
  - Short-term goals (e.g., "Walk 30 minutes every day")
  - Long-term goals (e.g., "Be fit within 3 months by burning 14 kg"). It can include multiple short-term goals
  - Goal types: One-time or recurring
- **Milestones**: Checkpoints for long-term goals with tasks and performance evaluation at deadlines
- **Tasks**: Properties include name, association, deadline, reminderAt, repeat settings
- **Goal Properties**: Deadline, start date, rewards, motivation
- **Reminders**: Local notifications before task start
- **Dashboard**: View progress of goals, sub-goals, and tasks
- **Calendar**: View tasks and goals (English and Nepali calendars supported)

**Screens:**
- Personal Dashboard: Overview of goals, tasks, and progress
- Goal List: List of goals with add/edit options
- Goal Detail: Details of a goal, including milestones and tasks
- Add/Edit Goal: Form to create or modify goals
- Milestone List: List of milestones for a goal
- Task List: List of tasks for a milestone or goal
- Add/Edit Task: Form to create or modify tasks
- Personal Calendar: Calendar view of tasks and goals

**Database Tables:**
- `goal_categories`: (id, name, user_id, created_at, updated_at)
- `goals`: (id, category_id, user_id, name, description, type, priority, deadline, start_date, rewards, motivation, status, progress, created_at, updated_at)
- `milestones`: (id, goal_id, name, description, deadline, status, progress, created_at, updated_at)
- `tasks`: (id, milestone_id, goal_id, name, description, deadline, reminder_at, repeat_type, repeat_interval, status, completed_at, created_at, updated_at)
- `task_completions`: (id, task_id, completed_at, notes)

### 5.3 Financial Management Module

**Features:**
- **Income Sources**: Add and manage sources (e.g., salary, freelance)
- **Accounts**: Add accounts (e.g., bank, e-wallet, cash) with balances
- **Financial Categories & Items**: Categories and items for expense tracking
- **Income & Expenses**: Record income per source and expenses per category/item
- **Dashboard**: View financial data (daily, weekly, monthly, quarterly, yearly)
- **Transfers**: Move money between accounts
- **Lending**: Track money lent to friends with return expectation
- **Investments**: Track stocks, SIPs, insurance, etc.
- **Calendar**: View financial activities (English and Nepali calendars)
- **Recurring Expenses**: Add recurring costs with adjustable payment dates
- **Financial Planning**: Set budgets and estimate expenses for future months

**Screens:**
- Financial Dashboard: Summary of income, expenses, and balances
- Account List: List of accounts with add/edit options
- Add/Edit Account: Form to create or modify accounts
- Transaction List: List of transactions with add/edit options
- Add/Edit Transaction: Form for income, expenses, etc.
- Transfer: Form to move money between accounts
- Lend: Form to record lending
- Investment: Form to track investments
- Category List: List of categories with add/edit options
- Add/Edit Category: Form to create or modify categories
- Item List: List of items per category
- Add/Edit Item: Form to create or modify items
- Financial Calendar: Calendar view of financial activities
- Budget Setup: Set budgets per category
- Expense Estimation: Estimate future expenses based on budgets and history

**Database Tables:**
- `income_sources`: (id, user_id, name, description, is_active, created_at, updated_at)
- `accounts`: (id, user_id, name, type, balance, currency, is_active, created_at, updated_at)
- `financial_categories`: (id, user_id, name, type, budget_limit, created_at, updated_at)
- `financial_items`: (id, category_id, name, description, created_at, updated_at)
- `transactions`: (id, user_id, type, source_id, account_id, category_id, item_id, amount, currency, date, description, is_recurring, created_at, updated_at)
- `recurring_expenses`: (id, user_id, name, amount, currency, frequency, next_payment_date, account_id, category_id, is_active, created_at, updated_at)
- `investments`: (id, user_id, name, type, amount, purchase_date, current_value, account_id, notes, created_at, updated_at)
- `lendings`: (id, user_id, borrower_name, amount, currency, lend_date, expected_return_date, actual_return_date, status, notes, created_at, updated_at)
- `budgets`: (id, user_id, category_id, amount, currency, period_type, start_date, end_date, created_at, updated_at)

### 5.4 Settings Module

**Features:**
- Theme selection (light/dark)
- Language selection (English/Hindi)
- Sync settings (auto, periodic, enable/disable)
- Authentication management (e.g., biometric toggle)

**Screen:**
- Settings Screen: Options for all settings

## 6. Development Essentials

- **Biometric Login**: Implemented using the `local_auth` package
- **Offline-First**: All features functional offline; data stored in Sqflite and synced when online
- **Sync Mechanism**: Configurable sync (auto, periodic, manual); server as source of truth for conflicts
- **Themes**: Light and dark modes using Flutter's ThemeData
- **Localization**: English and Hindi support via Flutter's localization
- **Calendar Support**: English (default) and Nepali (via `nepali_date_picker` package)
- **UI Design**: Consistent, beautiful theme with `lucide_icons` for icons

## 7. Development Roadmap

### Phase 1: Project Foundation (Week 1-2)
- Initialize Flutter project with proper folder structure
- Setup development environment and CI/CD pipeline
- Add all required dependencies to pubspec.yaml
- Configure auto_route for navigation
- Setup get_it for dependency injection
- Create base theme and color schemes (light/dark)
- Setup localization for English and Hindi

### Phase 2: Data Layer (Week 3-4)
- Define all data models using freezed
- Implement Sqflite database schema and migrations
- Create repository pattern for data access
- Implement local storage services
- Setup secure storage for authentication tokens
- Create sync mechanism foundation

### Phase 3: Authentication & Core Setup (Week 5-6)
- Implement JWT-based authentication
- Add biometric authentication using local_auth
- Create authentication Bloc and states
- Implement login, register, and biometric setup screens
- Add splash screen and onboarding flow
- Setup navigation guards for authenticated routes

### Phase 4: Personal Management Module (Week 7-10)
- Create personal management data models
- Implement goal categories CRUD operations
- Build goal creation and management functionality
- Add milestone and task management
- Implement reminder system with local notifications
- Create personal dashboard with progress visualization
- Build calendar view for personal activities
- Add goal progress tracking and analytics

### Phase 5: Financial Management Module (Week 11-14)
- Create financial data models
- Implement account and income source management
- Build transaction recording and categorization
- Add financial dashboard with charts using fl_chart
- Implement transfer and lending functionality
- Create investment tracking features
- Build financial calendar view
- Add budget management and expense planning

### Phase 6: Advanced Features (Week 15-16)
- Implement data export functionality (PDF/Excel)
- Add analytics and insights screens
- Create backup and restore functionality
- Implement advanced filtering and search
- Add data visualization improvements
- Performance optimization

### Phase 8: Integration & Sync (Week 21-22)
- Integrate frontend with backend APIs
- Implement bidirectional sync functionality
- Add conflict resolution logic
- Test offline-first functionality
- Implement retry mechanisms for failed requests

### Phase 9: Testing & Quality Assurance (Week 23-24)
- Write comprehensive unit tests for Blocs
- Add widget tests for UI components
- Implement integration tests
- Perform manual testing on multiple devices
- Test biometric authentication on real devices

### Phase 10: Deployment & Launch (Week 25-26)
- Prepare app store assets (icons, screenshots, descriptions)
- Setup app signing and deployment pipeline
- Submit to Google Play Store and Apple App Store
- Create user documentation and support materials

## 8. Security Considerations

### Frontend Security:
- JWT tokens with proper expiration and refresh mechanism
- Secure token storage using `flutter_secure_storage`
- Biometric authentication as an additional security layer
- Encrypt sensitive data in local SQLite database
- Input validation and sanitization
- Local-first approach minimizes data exposure

## 9. Performance Optimization

### Frontend Optimization:
- Lazy loading for large lists using ListView.builder
- Image caching with `cached_network_image`
- Efficient state management with Bloc pattern
- Code splitting and tree shaking for smaller app size
- Database indexing for faster queries

## 10. Accessibility & Usability

### Accessibility Features:
- Screen reader support with proper semantic labels
- High contrast mode support
- Adjustable font sizes
- Touch target size compliance (minimum 44dp)
- Voice control compatibility

### Usability Features:
- Intuitive navigation with bottom navigation bar
- Swipe gestures for common actions
- Undo/redo functionality for accidental deletions
- Search functionality across all modules
- Keyboard shortcuts for power users

## 11. Error Handling & Logging

### Error Handling:
- Graceful error handling with user-friendly messages
- Retry mechanisms for network failures
- Offline fallback with sync when online
- Form validation with clear error indicators
- Crash reporting and analytics

### Logging Strategy:
- Debug logs for development
- Error logs for production issues
- User action analytics for app improvement
- Performance monitoring and alerts

## 12. Testing Strategy

- **Unit Tests**: All Blocs, repositories, and services
- **Widget Tests**: All custom widgets and screens
- **Integration Tests**: Complete user flows
- **Manual Testing**: Real device testing for biometrics and notifications

## 13. Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android SDK for Android development
- Xcode for iOS development (macOS only)

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Configure the backend API endpoints
4. Run `flutter run` to start the app

### Project Structure
```
lib/
├── main.dart
├── apps/
│   ├── dynamic_form/
│   ├── method_channel/
│   ├── mini_ecommerce/
│   ├── nested_bottom_nav/
│   └── offline_todo/
├── common/
├── core/
│   ├── app.dart
│   ├── service_locator.dart
│   ├── auth/
│   └── di/
└── themes/
```
