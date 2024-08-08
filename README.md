### App Description

This is a basic user authentication application built with Vapor, a server-side Swift web framework. The application includes features for user registration and login, leveraging the power of the Vapor framework and Fluent ORM for database interactions. The app uses SQLite as its database.

### Features

- **User Registration**: New users can create an account by providing a username and password.
- **User Login**: Registered users can log in with their username and password.
- **Password Hashing**: User passwords are securely hashed using Bcrypt.
- **Login Attempt Tracking**: The app tracks the number of login attempts and the time of the last login attempt for each user.
- **HTML Templates**: The app uses Leaf templates for rendering the registration and login pages.

### Database

- **Type**: SQLite
- **Schema**: The app includes a `users` table with fields for user ID, username, password, login attempts, last login attempt, remember me token, created at, and updated at timestamps.
