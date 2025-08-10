# Flutter Productivity App - Backend

## 1. Overview
A Node.js backend service with Express framework that provides RESTful APIs for the Flutter Productivity App. The backend handles user authentication, data synchronization, and provides endpoints for personal management and financial management features.

## 2. Tech Stack

### Backend: Node.js with Express
- **Framework**: Express.js for RESTful APIs
- **Authentication**: JWT (JSON Web Tokens)
- **Database**: MongoDB or PostgreSQL (to be decided during backend setup)
- **Security**: bcrypt for password hashing
- **Validation**: Input validation and sanitization
- **Middleware**: CORS, rate limiting, authentication middleware

### Database Options:
- **MongoDB**: NoSQL database for flexible document storage
- **PostgreSQL**: Relational database for structured data

## 3. API Endpoints

### 3.1 Authentication APIs

#### User Authentication
```
POST /auth/login
- Description: Authenticate user and return JWT token
- Body: { email, password }
- Response: { token, user_profile }

POST /auth/register
- Description: Create a new user account
- Body: { email, password, name }
- Response: { success, user_id }

POST /auth/refresh
- Description: Refresh JWT token
- Headers: Authorization: Bearer <refresh_token>
- Response: { token }

POST /auth/logout
- Description: Invalidate token
- Headers: Authorization: Bearer <token>
- Response: { success }

GET /auth/profile
- Description: Get user profile
- Headers: Authorization: Bearer <token>
- Response: { user_profile }

PUT /auth/profile
- Description: Update user profile
- Headers: Authorization: Bearer <token>
- Body: { name, email, preferences }
- Response: { success, user_profile }
```

### 3.2 Personal Management APIs

#### Goal Categories
```
GET /api/goal-categories
- Description: Get user's goal categories
- Headers: Authorization: Bearer <token>
- Response: { categories[] }

POST /api/goal-categories
- Description: Create new goal category
- Headers: Authorization: Bearer <token>
- Body: { name, description }
- Response: { success, category_id }

PUT /api/goal-categories/:id
- Description: Update goal category
- Headers: Authorization: Bearer <token>
- Body: { name, description }
- Response: { success }

DELETE /api/goal-categories/:id
- Description: Delete goal category
- Headers: Authorization: Bearer <token>
- Response: { success }
```

#### Goals
```
GET /api/goals
- Description: Get user's goals with filters
- Headers: Authorization: Bearer <token>
- Query: ?category_id=&status=&type=
- Response: { goals[] }

POST /api/goals
- Description: Create new goal
- Headers: Authorization: Bearer <token>
- Body: { category_id, name, description, type, priority, deadline, start_date, rewards, motivation }
- Response: { success, goal_id }

PUT /api/goals/:id
- Description: Update goal
- Headers: Authorization: Bearer <token>
- Body: { name, description, type, priority, deadline, rewards, motivation, status }
- Response: { success }

DELETE /api/goals/:id
- Description: Delete goal
- Headers: Authorization: Bearer <token>
- Response: { success }

GET /api/goals/:id/progress
- Description: Get goal progress
- Headers: Authorization: Bearer <token>
- Response: { progress_percentage, completed_tasks, total_tasks }
```

#### Milestones
```
GET /api/milestones
- Description: Get milestones for a goal
- Headers: Authorization: Bearer <token>
- Query: ?goal_id=
- Response: { milestones[] }

POST /api/milestones
- Description: Create new milestone
- Headers: Authorization: Bearer <token>
- Body: { goal_id, name, description, deadline }
- Response: { success, milestone_id }

PUT /api/milestones/:id
- Description: Update milestone
- Headers: Authorization: Bearer <token>
- Body: { name, description, deadline, status }
- Response: { success }

DELETE /api/milestones/:id
- Description: Delete milestone
- Headers: Authorization: Bearer <token>
- Response: { success }
```

#### Tasks
```
GET /api/tasks
- Description: Get tasks with filters
- Headers: Authorization: Bearer <token>
- Query: ?goal_id=&milestone_id=&status=&date=
- Response: { tasks[] }

POST /api/tasks
- Description: Create new task
- Headers: Authorization: Bearer <token>
- Body: { milestone_id, goal_id, name, description, deadline, reminder_at, repeat_type, repeat_interval }
- Response: { success, task_id }

PUT /api/tasks/:id
- Description: Update task
- Headers: Authorization: Bearer <token>
- Body: { name, description, deadline, reminder_at, repeat_type, repeat_interval, status }
- Response: { success }

DELETE /api/tasks/:id
- Description: Delete task
- Headers: Authorization: Bearer <token>
- Response: { success }

POST /api/tasks/:id/complete
- Description: Mark task as completed
- Headers: Authorization: Bearer <token>
- Body: { notes }
- Response: { success, completed_at }
```

### 3.3 Financial Management APIs

#### Income Sources
```
GET /api/income-sources
- Description: Get user's income sources
- Headers: Authorization: Bearer <token>
- Response: { income_sources[] }

POST /api/income-sources
- Description: Create income source
- Headers: Authorization: Bearer <token>
- Body: { name, description }
- Response: { success, source_id }

PUT /api/income-sources/:id
- Description: Update income source
- Headers: Authorization: Bearer <token>
- Body: { name, description, is_active }
- Response: { success }

DELETE /api/income-sources/:id
- Description: Delete income source
- Headers: Authorization: Bearer <token>
- Response: { success }
```

#### Accounts
```
GET /api/accounts
- Description: Get user's accounts
- Headers: Authorization: Bearer <token>
- Response: { accounts[] }

POST /api/accounts
- Description: Create account
- Headers: Authorization: Bearer <token>
- Body: { name, type, initial_balance, currency }
- Response: { success, account_id }

PUT /api/accounts/:id
- Description: Update account
- Headers: Authorization: Bearer <token>
- Body: { name, type, currency, is_active }
- Response: { success }

DELETE /api/accounts/:id
- Description: Delete account
- Headers: Authorization: Bearer <token>
- Response: { success }

GET /api/accounts/:id/balance
- Description: Get account balance
- Headers: Authorization: Bearer <token>
- Response: { current_balance, currency }
```

#### Financial Categories
```
GET /api/financial-categories
- Description: Get financial categories
- Headers: Authorization: Bearer <token>
- Response: { categories[] }

POST /api/financial-categories
- Description: Create category
- Headers: Authorization: Bearer <token>
- Body: { name, type, budget_limit }
- Response: { success, category_id }

PUT /api/financial-categories/:id
- Description: Update category
- Headers: Authorization: Bearer <token>
- Body: { name, type, budget_limit }
- Response: { success }

DELETE /api/financial-categories/:id
- Description: Delete category
- Headers: Authorization: Bearer <token>
- Response: { success }
```

#### Financial Items
```
GET /api/financial-items
- Description: Get items by category
- Headers: Authorization: Bearer <token>
- Query: ?category_id=
- Response: { items[] }

POST /api/financial-items
- Description: Create item
- Headers: Authorization: Bearer <token>
- Body: { category_id, name, description }
- Response: { success, item_id }

PUT /api/financial-items/:id
- Description: Update item
- Headers: Authorization: Bearer <token>
- Body: { name, description }
- Response: { success }

DELETE /api/financial-items/:id
- Description: Delete item
- Headers: Authorization: Bearer <token>
- Response: { success }
```

#### Transactions
```
GET /api/transactions
- Description: Get transactions with filters
- Headers: Authorization: Bearer <token>
- Query: ?type=&account_id=&category_id=&start_date=&end_date=
- Response: { transactions[] }

POST /api/transactions
- Description: Create transaction
- Headers: Authorization: Bearer <token>
- Body: { type, source_id, account_id, category_id, item_id, amount, currency, date, description, is_recurring }
- Response: { success, transaction_id }

PUT /api/transactions/:id
- Description: Update transaction
- Headers: Authorization: Bearer <token>
- Body: { type, amount, currency, date, description }
- Response: { success }

DELETE /api/transactions/:id
- Description: Delete transaction
- Headers: Authorization: Bearer <token>
- Response: { success }

GET /api/transactions/summary
- Description: Get financial summary
- Headers: Authorization: Bearer <token>
- Query: ?period=&start_date=&end_date=
- Response: { total_income, total_expenses, net_amount, category_breakdown[] }
```

#### Investments
```
GET /api/investments
- Description: Get user's investments
- Headers: Authorization: Bearer <token>
- Response: { investments[] }

POST /api/investments
- Description: Create investment
- Headers: Authorization: Bearer <token>
- Body: { name, type, amount, purchase_date, account_id, notes }
- Response: { success, investment_id }

PUT /api/investments/:id
- Description: Update investment
- Headers: Authorization: Bearer <token>
- Body: { name, type, current_value, notes }
- Response: { success }

DELETE /api/investments/:id
- Description: Delete investment
- Headers: Authorization: Bearer <token>
- Response: { success }
```

#### Lendings
```
GET /api/lendings
- Description: Get lending records
- Headers: Authorization: Bearer <token>
- Response: { lendings[] }

POST /api/lendings
- Description: Create lending record
- Headers: Authorization: Bearer <token>
- Body: { borrower_name, amount, currency, lend_date, expected_return_date, notes }
- Response: { success, lending_id }

PUT /api/lendings/:id
- Description: Update lending record
- Headers: Authorization: Bearer <token>
- Body: { expected_return_date, actual_return_date, status, notes }
- Response: { success }

DELETE /api/lendings/:id
- Description: Delete lending record
- Headers: Authorization: Bearer <token>
- Response: { success }
```

### 3.4 Sync & Analytics APIs

#### Data Synchronization
```
POST /api/sync
- Description: Bidirectional data sync
- Headers: Authorization: Bearer <token>
- Body: { last_sync_timestamp, local_changes[] }
- Response: { server_changes[], new_sync_timestamp }

POST /api/backup
- Description: Create data backup
- Headers: Authorization: Bearer <token>
- Response: { backup_id, backup_url }

GET /api/backup
- Description: Get backup data
- Headers: Authorization: Bearer <token>
- Query: ?backup_id=
- Response: { backup_data }

POST /api/restore
- Description: Restore from backup
- Headers: Authorization: Bearer <token>
- Body: { backup_id }
- Response: { success }
```

#### Analytics
```
GET /api/analytics/personal
- Description: Get personal productivity analytics
- Headers: Authorization: Bearer <token>
- Query: ?period=&start_date=&end_date=
- Response: { goal_completion_rate, task_statistics, productivity_trends }

GET /api/analytics/financial
- Description: Get financial analytics
- Headers: Authorization: Bearer <token>
- Query: ?period=&start_date=&end_date=
- Response: { spending_patterns, income_trends, budget_analysis, investment_performance }
```

## 4. Database Schema

### Authentication Tables
```sql
users: (id, email, password_hash, name, created_at, updated_at, last_login)
user_sessions: (id, user_id, token_hash, expires_at, created_at)
```

### Personal Management Tables
```sql
goal_categories: (id, name, user_id, created_at, updated_at)
goals: (id, category_id, user_id, name, description, type, priority, deadline, start_date, rewards, motivation, status, progress, created_at, updated_at)
milestones: (id, goal_id, name, description, deadline, status, progress, created_at, updated_at)
tasks: (id, milestone_id, goal_id, name, description, deadline, reminder_at, repeat_type, repeat_interval, status, completed_at, created_at, updated_at)
task_completions: (id, task_id, completed_at, notes)
```

### Financial Management Tables
```sql
income_sources: (id, user_id, name, description, is_active, created_at, updated_at)
accounts: (id, user_id, name, type, balance, currency, is_active, created_at, updated_at)
financial_categories: (id, user_id, name, type, budget_limit, created_at, updated_at)
financial_items: (id, category_id, name, description, created_at, updated_at)
transactions: (id, user_id, type, source_id, account_id, category_id, item_id, amount, currency, date, description, is_recurring, created_at, updated_at)
recurring_expenses: (id, user_id, name, amount, currency, frequency, next_payment_date, account_id, category_id, is_active, created_at, updated_at)
investments: (id, user_id, name, type, amount, purchase_date, current_value, account_id, notes, created_at, updated_at)
lendings: (id, user_id, borrower_name, amount, currency, lend_date, expected_return_date, actual_return_date, status, notes, created_at, updated_at)
budgets: (id, user_id, category_id, amount, currency, period_type, start_date, end_date, created_at, updated_at)
```

## 5. Development Roadmap

### Phase 7: Backend Development (Week 17-20)
- Setup Node.js backend with Express
- Implement all REST APIs
- Add JWT authentication middleware
- Setup database (MongoDB/PostgreSQL)
- Implement sync endpoints
- Add data validation and error handling
- Setup backend testing

### Phase 8: Integration & Testing (Week 21-22)
- Integrate with frontend Flutter app
- Implement bidirectional sync functionality
- Add conflict resolution logic
- Test API endpoints
- Implement retry mechanisms for failed requests

### Phase 9: Security & Performance (Week 23-24)
- Implement rate limiting and security middleware
- Add comprehensive error handling
- Performance optimization and caching
- Load testing for APIs
- Security auditing

### Phase 10: Deployment (Week 25-26)
- Deploy to production environment (AWS/Google Cloud/Digital Ocean)
- Setup monitoring and logging
- Configure CI/CD pipelines
- Database setup and migration scripts
- Production testing and go-live

## 6. Security Considerations

### Backend Security:
- **Authentication**: JWT tokens with proper expiration and refresh mechanism
- **Password Security**: bcrypt for password hashing with salt
- **API Security**: Rate limiting to prevent abuse
- **Input Validation**: Comprehensive validation and sanitization
- **HTTPS**: Enforce SSL/TLS for all communications
- **CORS**: Configure appropriate CORS policies
- **SQL Injection**: Use parameterized queries/ORM
- **Authorization**: Role-based access control

### Data Security:
- **Encryption**: Encrypt sensitive data at rest
- **Backup Security**: Secure backup storage and access
- **Audit Logging**: Log all data access and modifications
- **GDPR Compliance**: Data privacy and user rights

## 7. Performance Optimization

### Backend Optimization:
- **Database**: Query optimization with proper indexing
- **Caching**: Redis for frequently accessed data
- **Pagination**: Implement pagination for large datasets
- **Compression**: Gzip compression for API responses
- **Connection Pooling**: Database connection pooling
- **Load Balancing**: Horizontal scaling with load balancers

### Monitoring:
- **API Monitoring**: Response time and error rate tracking
- **Database Monitoring**: Query performance and resource usage
- **Server Monitoring**: CPU, memory, and disk usage
- **Error Tracking**: Comprehensive error logging and alerting

## 8. Testing Strategy

### Backend Testing:
- **Unit Tests**: Test individual functions and modules
- **Integration Tests**: Test API endpoints end-to-end
- **Load Testing**: Test performance under high load
- **Security Testing**: Penetration testing and vulnerability assessment
- **Database Testing**: Test data integrity and performance

### Testing Tools:
- **Jest/Mocha**: Unit testing framework
- **Supertest**: API testing
- **Artillery/JMeter**: Load testing
- **Postman**: Manual API testing

## 9. Deployment Strategy

### Production Environment:
- **Cloud Provider**: AWS/Google Cloud/Digital Ocean
- **Container**: Docker for containerization
- **Orchestration**: Docker Compose or Kubernetes
- **Database**: Managed database service (AWS RDS, Google Cloud SQL)
- **CDN**: Content delivery network for static assets
- **Monitoring**: Application performance monitoring (APM)

### CI/CD Pipeline:
- **Version Control**: Git with feature branches
- **Automated Testing**: Run tests on every commit
- **Build Process**: Automated build and deployment
- **Environment Management**: Development, staging, and production environments

## 10. Getting Started

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn
- MongoDB or PostgreSQL
- Git

### Installation
1. Clone the repository
2. Run `npm install` to install dependencies
3. Configure environment variables (.env file)
4. Setup database connection
5. Run database migrations
6. Start the development server with `npm run dev`

### Environment Variables
```
NODE_ENV=development
PORT=3000
DATABASE_URL=your_database_url
JWT_SECRET=your_jwt_secret
JWT_REFRESH_SECRET=your_refresh_secret
BCRYPT_ROUNDS=12
```

### Project Structure
```
backend/
├── src/
│   ├── controllers/
│   ├── models/
│   ├── routes/
│   ├── middleware/
│   ├── services/
│   ├── utils/
│   └── app.js
├── tests/
├── migrations/
├── config/
├── package.json
└── README.md
```
