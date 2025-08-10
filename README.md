# Flutter Productivity App

## Overview
A comprehensive productivity application designed to enhance personal productivity by helping users manage daily activities and finances. The app features two core modules—Personal Management and Financial Management—with an offline-first approach, biometric authentication, multi-language support (English and Hindi), and a consistent UI with light and dark themes. Data syncs with a Node.js backend when online, based on user-configurable sync settings.

## Documentation Structure

This project is split into two main components:

### 📱 Frontend (Flutter App)
For detailed information about the Flutter mobile application, see:
**[Frontend README](./frontend-readme.md)**

Includes:
- Flutter architecture and tech stack
- UI/UX design and components
- Local data storage with Sqflite
- Biometric authentication
- Offline-first functionality
- State management with Bloc
- Development setup and testing

### 🔧 Backend (Node.js API)
For detailed information about the backend API service, see:
**[Backend README](./backend-readme.md)**

Includes:
- REST API endpoints documentation
- Database schema and design
- Authentication and security
- Data synchronization
- Deployment and scaling
- Performance optimization

## Core Features

- **Manage Daily Activities**: Set goals, track tasks, and monitor progress
- **Manage Finances**: Track income, expenses, budgets, and investments
- **Habit Tracking**: Track daily habits and build streaks
- **Data Analytics**: Insights and reports on productivity and financial patterns
- **Backup & Restore**: Cloud backup of data with restore functionality
- **Export Features**: Export data to PDF/Excel for external analysis
- **Extensibility**: Placeholder for additional features to be added later

## Quick Start

### Frontend Development
```bash
# Install Flutter dependencies
flutter pub get

# Run the app
flutter run
```

### Backend Development
```bash
# Install Node.js dependencies
npm install

# Setup environment variables
cp .env.example .env

# Start development server
npm run dev
```

## Project Structure

```
├── lib/                    # Flutter app source code
├── android/               # Android platform files
├── ios/                   # iOS platform files
├── backend/               # Node.js backend (to be created)
├── frontend-readme.md     # Frontend documentation
├── backend-readme.md      # Backend documentation
└── README.md             # This file
```

## Tech Stack

### Frontend
- **Flutter**: Cross-platform mobile framework
- **Dart**: Programming language
- **Bloc**: State management
- **Sqflite**: Local database
- **Dio**: HTTP client

### Backend
- **Node.js**: Runtime environment
- **Express**: Web framework
- **MongoDB/PostgreSQL**: Database
- **JWT**: Authentication

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation in frontend-readme.md and backend-readme.md



4. App Architecture

Modular Design: Separate modules for Personal Management, Financial Management, Authentication, and Settings.
Offline-First: All data is stored locally using Sqflite and synced with the backend when online.
State Management: Bloc pattern for managing app state.
Routing: auto_route for navigation between screens.
Dependency Injection: get_it for managing dependencies.
API Communication: Dio for HTTP requests to the backend.
Data Models: Immutable classes using freezed for type safety and serialization.

5. Modules and Features
5.1 Authentication Module

Features:
User login and registration via email/password.
Biometric authentication (fingerprint/face recognition) for secure access.


Screens:
Login Screen: Email/password input and biometric option.
Register Screen: Form for account creation.
Biometric Setup Screen: Enable biometric login.


Backend APIs:
POST /auth/login: Authenticate user and return JWT token.
POST /auth/register: Create a new user account.



5.2 Personal Management Module
Features

Goal Categories: Users can create categories (e.g., Health, Work, Hobby, Learning).
Goal Creation: 
Short-term goals (e.g., "Walk 30 minutes every day").
Long-term goals (e.g., "Be fit within 3 months by burning 14 kg") with milestones.
Goal types: One-time or recurring.


Milestones: Checkpoints for long-term goals with tasks and performance evaluation at deadlines. Options to extend or add new short-term goals if unmet.
Tasks: 
Properties: Name, association (short-term goal or untracked), deadline (date/time), reminderAt, repeat (e.g., daily, weekly).


Goal Properties: Deadline, start date, rewards, motivation (for reference).
Reminders: Local notifications before task start (customizable or default time).
Dashboard: View progress of goals, sub-goals, and tasks; add/modify them.
Calendar: View tasks and goals (English and Nepali calendars supported).
Settings: Manage authentication, themes, and language.

Screens

Personal Dashboard: Overview of goals, tasks, and progress.
Goal List: List of goals with add/edit options.
Goal Detail: Details of a goal, including milestones and tasks.
Add/Edit Goal: Form to create or modify goals.
Milestone List: List of milestones for a goal.
Task List: List of tasks for a milestone or goal.
Add/Edit Task: Form to create or modify tasks.
Personal Calendar: Calendar view of tasks and goals.

Database Tables

goal_categories: (id, name, user_id, created_at, updated_at)
goals: (id, category_id, user_id, name, description, type, priority, deadline, start_date, rewards, motivation, status, progress, created_at, updated_at)
milestones: (id, goal_id, name, description, deadline, status, progress, created_at, updated_at)
tasks: (id, milestone_id, goal_id, name, description, deadline, reminder_at, repeat_type, repeat_interval, status, completed_at, created_at, updated_at)
task_completions: (id, task_id, completed_at, notes)

5.3 Financial Management Module
Features

Income Sources: Add and manage sources (e.g., salary, freelance).
Accounts: Add accounts (e.g., bank, e-wallet, cash) with balances.
Financial Categories & Items: 
Categories (e.g., Vegetable).
Items (e.g., cauliflower, tomato, paneer).


Income & Expenses: Record income per source and expenses per source, category, item, with descriptions.
Dashboard: View financial data (daily, weekly, monthly, quarterly, yearly).
Transfers: Move money between accounts.
Lending: Track money lent to friends with return expectation.
Investments: Track stocks, SIPs, insurance, etc.
Calendar: View financial activities (English and Nepali calendars).
Recurring Expenses: Add recurring costs (e.g., rent) with adjustable payment dates.
Financial Planning: Set budgets and estimate expenses for future months.

Screens

Financial Dashboard: Summary of income, expenses, and balances.
Account List: List of accounts with add/edit options.
Add/Edit Account: Form to create or modify accounts.
Transaction List: List of transactions with add/edit options.
Add/Edit Transaction: Form for income, expenses, etc.
Transfer: Form to move money between accounts.
Lend: Form to record lending.
Investment: Form to track investments.
Category List: List of categories with add/edit options.
Add/Edit Category: Form to create or modify categories.
Item List: List of items per category.
Add/Edit Item: Form to create or modify items.
Financial Calendar: Calendar view of financial activities.
Budget Setup: Set budgets per category.
Expense Estimation: Estimate future expenses based on budgets and history.

Database Tables

income_sources: (id, user_id, name, description, is_active, created_at, updated_at)
accounts: (id, user_id, name, type, balance, currency, is_active, created_at, updated_at)
financial_categories: (id, user_id, name, type, budget_limit, created_at, updated_at)
financial_items: (id, category_id, name, description, created_at, updated_at)
transactions: (id, user_id, type, source_id, account_id, category_id, item_id, amount, currency, date, description, is_recurring, created_at, updated_at)
recurring_expenses: (id, user_id, name, amount, currency, frequency, next_payment_date, account_id, category_id, is_active, created_at, updated_at)
investments: (id, user_id, name, type, amount, purchase_date, current_value, account_id, notes, created_at, updated_at)
lendings: (id, user_id, borrower_name, amount, currency, lend_date, expected_return_date, actual_return_date, status, notes, created_at, updated_at)
budgets: (id, user_id, category_id, amount, currency, period_type, start_date, end_date, created_at, updated_at)

5.4 Settings Module

Features:
Theme selection (light/dark).
Language selection (English/Hindi).
Sync settings (auto, periodic, enable/disable).
Authentication management (e.g., biometric toggle).


Screen: 
Settings Screen: Options for all settings.



6. Essentials

Biometric Login: Implemented using the local_auth package.
Offline-First: All features functional offline; data stored in Sqflite and synced when online.
Sync Mechanism: Configurable sync (auto, periodic, manual); server as source of truth for conflicts.
Themes: Light and dark modes using Flutter’s ThemeData.
Localization: English and Hindi support via Flutter’s localization.
Calendar Support: English (default) and Nepali (via nepali_date_picker package).
UI Design: Consistent, beautiful theme with lucide_icons for icons.

7. Backend APIs

Authentication:
POST /auth/login: Returns JWT token and user profile.
POST /auth/register: Creates user account.
POST /auth/refresh: Refresh JWT token.
POST /auth/logout: Invalidate token.
GET /auth/profile: Get user profile.
PUT /auth/profile: Update user profile.


Personal Management:
GET /api/goal-categories: Get user's goal categories.
POST /api/goal-categories: Create new goal category.
PUT /api/goal-categories/:id: Update goal category.
DELETE /api/goal-categories/:id: Delete goal category.

GET /api/goals: Get user's goals with filters.
POST /api/goals: Create new goal.
PUT /api/goals/:id: Update goal.
DELETE /api/goals/:id: Delete goal.
GET /api/goals/:id/progress: Get goal progress.

GET /api/milestones: Get milestones for a goal.
POST /api/milestones: Create new milestone.
PUT /api/milestones/:id: Update milestone.
DELETE /api/milestones/:id: Delete milestone.

GET /api/tasks: Get tasks with filters.
POST /api/tasks: Create new task.
PUT /api/tasks/:id: Update task.
DELETE /api/tasks/:id: Delete task.
POST /api/tasks/:id/complete: Mark task as completed.


Financial Management:
GET /api/income-sources: Get user's income sources.
POST /api/income-sources: Create income source.
PUT /api/income-sources/:id: Update income source.
DELETE /api/income-sources/:id: Delete income source.

GET /api/accounts: Get user's accounts.
POST /api/accounts: Create account.
PUT /api/accounts/:id: Update account.
DELETE /api/accounts/:id: Delete account.
GET /api/accounts/:id/balance: Get account balance.

GET /api/financial-categories: Get financial categories.
POST /api/financial-categories: Create category.
PUT /api/financial-categories/:id: Update category.
DELETE /api/financial-categories/:id: Delete category.

GET /api/financial-items: Get items by category.
POST /api/financial-items: Create item.
PUT /api/financial-items/:id: Update item.
DELETE /api/financial-items/:id: Delete item.

GET /api/transactions: Get transactions with filters.
POST /api/transactions: Create transaction.
PUT /api/transactions/:id: Update transaction.
DELETE /api/transactions/:id: Delete transaction.
GET /api/transactions/summary: Get financial summary.

GET /api/investments: Get user's investments.
POST /api/investments: Create investment.
PUT /api/investments/:id: Update investment.
DELETE /api/investments/:id: Delete investment.

GET /api/lendings: Get lending records.
POST /api/lendings: Create lending record.
PUT /api/lendings/:id: Update lending record.
DELETE /api/lendings/:id: Delete lending record.


Sync & Analytics:
POST /api/sync: Bidirectional data sync.
GET /api/analytics/personal: Get personal productivity analytics.
GET /api/analytics/financial: Get financial analytics.
POST /api/backup: Create data backup.
GET /api/backup: Get backup data.
POST /api/restore: Restore from backup.



8. Development Roadmap

Phase 1: Project Foundation (Week 1-2)
- Initialize Flutter project with proper folder structure
- Setup development environment and CI/CD pipeline
- Add all required dependencies to pubspec.yaml
- Configure auto_route for navigation
- Setup get_it for dependency injection
- Create base theme and color schemes (light/dark)
- Setup localization for English and Hindi

Phase 2: Data Layer (Week 3-4)
- Define all data models using freezed
- Implement Sqflite database schema and migrations
- Create repository pattern for data access
- Implement local storage services
- Setup secure storage for authentication tokens
- Create sync mechanism foundation

Phase 3: Authentication & Core Setup (Week 5-6)
- Implement JWT-based authentication
- Add biometric authentication using local_auth
- Create authentication Bloc and states
- Implement login, register, and biometric setup screens
- Add splash screen and onboarding flow
- Setup navigation guards for authenticated routes

Phase 4: Personal Management Module (Week 7-10)
- Create personal management data models
- Implement goal categories CRUD operations
- Build goal creation and management functionality
- Add milestone and task management
- Implement reminder system with local notifications
- Create personal dashboard with progress visualization
- Build calendar view for personal activities
- Add goal progress tracking and analytics

Phase 5: Financial Management Module (Week 11-14)
- Create financial data models
- Implement account and income source management
- Build transaction recording and categorization
- Add financial dashboard with charts using fl_chart
- Implement transfer and lending functionality
- Create investment tracking features
- Build financial calendar view
- Add budget management and expense planning

Phase 6: Advanced Features (Week 15-16)
- Implement data export functionality (PDF/Excel)
- Add analytics and insights screens
- Create backup and restore functionality
- Implement advanced filtering and search
- Add data visualization improvements
- Performance optimization

Phase 7: Backend Development (Week 17-20)
- Setup Node.js backend with Express
- Implement all REST APIs
- Add JWT authentication middleware
- Setup database (MongoDB/PostgreSQL)
- Implement sync endpoints
- Add data validation and error handling
- Setup backend testing

Phase 8: Integration & Sync (Week 21-22)
- Integrate frontend with backend APIs
- Implement bidirectional sync functionality
- Add conflict resolution logic
- Test offline-first functionality
- Implement retry mechanisms for failed requests

Phase 9: Testing & Quality Assurance (Week 23-24)
- Write comprehensive unit tests for Blocs
- Add widget tests for UI components
- Implement integration tests
- Perform manual testing on multiple devices
- Test biometric authentication on real devices
- Load testing for backend APIs

Phase 10: Deployment & Launch (Week 25-26)
- Prepare app store assets (icons, screenshots, descriptions)
- Setup app signing and deployment pipeline
- Deploy backend to production environment
- Setup monitoring and analytics
- Submit to Google Play Store and Apple App Store
- Create user documentation and support materials

Testing Strategy:
- Unit Tests: All Blocs, repositories, and services
- Widget Tests: All custom widgets and screens
- Integration Tests: Complete user flows
- Manual Testing: Real device testing for biometrics and notifications
- Backend Testing: API testing with automated test suites

Deployment Strategy:
- Frontend: Build APK/IPA for app stores
- Backend: Deploy to cloud services (AWS/Google Cloud/Digital Ocean)
- Database: Managed database service for production
- CI/CD: Automated testing and deployment pipelines

9. Security Considerations

Authentication Security:
- JWT tokens with proper expiration and refresh mechanism
- Secure token storage using flutter_secure_storage
- Biometric authentication as an additional security layer
- Password strength validation and hashing (bcrypt)

Data Security:
- Encrypt sensitive data in local SQLite database
- Use HTTPS for all API communications
- Implement API rate limiting to prevent abuse
- Input validation and sanitization on both frontend and backend

Privacy:
- Local-first approach minimizes data exposure
- Optional cloud sync with user consent
- Clear privacy policy regarding data collection and usage
- GDPR compliance for European users

10. Performance Optimization

Frontend Optimization:
- Lazy loading for large lists using ListView.builder
- Image caching with cached_network_image
- Efficient state management with Bloc pattern
- Code splitting and tree shaking for smaller app size
- Database indexing for faster queries

Backend Optimization:
- Database query optimization with proper indexing
- Caching frequently accessed data
- Pagination for large datasets
- Compression for API responses
- Connection pooling for database connections

11. Accessibility & Usability

Accessibility Features:
- Screen reader support with proper semantic labels
- High contrast mode support
- Adjustable font sizes
- Touch target size compliance (minimum 44dp)
- Voice control compatibility

Usability Features:
- Intuitive navigation with bottom navigation bar
- Swipe gestures for common actions
- Undo/redo functionality for accidental deletions
- Search functionality across all modules
- Keyboard shortcuts for power users

12. Error Handling & Logging

Error Handling:
- Graceful error handling with user-friendly messages
- Retry mechanisms for network failures
- Offline fallback with sync when online
- Form validation with clear error indicators
- Crash reporting and analytics

Logging Strategy:
- Debug logs for development
- Error logs for production issues
- User action analytics for app improvement
- Performance monitoring and alerts

13. Maintenance & Updates

Update Strategy:
- Regular security updates
- Feature updates based on user feedback
- Database migration handling for schema changes
- Backward compatibility considerations
- A/B testing for new features

Monitoring:
- App crash monitoring
- Performance metrics tracking
- User engagement analytics
- API response time monitoring
- Database performance monitoring
