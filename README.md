# User Management App

## Overview

Welcome to the User Management App repository! This Flutter application displays a list of GitHub users on the home screen and provides detailed profiles for selected users. To maintain a clean and maintainable application architecture, the BLoC (Business Logic Component) pattern is used.

## Features

- **Splash Screen**: Displays a visually appealing splash screen when the application starts, smoothly transitioning to the main application.
- **Home Screen**: Shows a list of GitHub users with infinite scroll and pull-to-refresh functionality. Clicking on a user allows you to view their profile.
- **Profile Screen**: Displays detailed information about the selected user.

## Widgets

- **ActionsList**: Displays a list of actions related to the repository.
- **Clickable_AD_Image**: Shows advertisements in the user list.
- **CustomAppBar**: Provides a customized app bar with branding and functionality.
- **CustomProfileHeader**: Displays user profile details with a customized header.
- **DotLoadingWidget**: Shows a loading indicator while fetching data.

## Key Design Decisions

### Splash Screen

**Design and Purpose**:  The splash screen is designed to provide a visually appealing introduction to the application, incorporating brand elements and setting the tone for the user experience. This screen is displayed while the application initializes and transitions smoothly to the main application.

### State Management

**BLoC Pattern**: The BLoC pattern was chosen for its effective approach to managing state and business logic separately from UI components. This makes the application easier to test and maintain. UserBloc manages user data loading and pagination, while ProfileBloc handles user profile data.

### Design

**Clean and Modern**: The design is clean and modern, featuring consistent colors and spacing. Detailed design elements are described in the attached document.

## Code Structure

The project consists of several main directories and files, each serving a specific purpose:

```plaintext
├── core/
│   ├── error/                # Error handling and custom exceptions
│   ├── utils/                # Utility functions and helpers
│   ├── network/              # Network-related code, e.g., API services
│   ├── usecases/             # Business logic and use cases
│   └── theme/                # Themes and styles related to the app
├── features/
│   ├── users/
│   │   ├── data/             # Data layer for user-related features
│   │   │   ├── datasources/  # Data sources, e.g., API or local database
│   │   │   ├── models/       # Data models
│   │   │   └── repositories/  # Repositories for user data
│   │   ├── domain/           # Domain layer for user-related features
│   │   │   ├── entities/     # Domain entities
│   │   │   ├── repositories/  # Domain repositories
│   │   │   └── usecases/     # Use cases for user-related actions
│   │   ├── presentation/      # Presentation layer for user-related features
│   │   │   ├── bloc/         # BLoC files for state management
│   │   │   │   ├── user_bloc.dart
│   │   │   │   ├── user_event.dart
│   │   │   │   └── user_state.dart
│   │   │   ├── pages/        # Pages/screens related to users
│   │   │   ├── widgets/      # Widgets related to user screens
│   │   └── injection/        # Dependency injection for user features
│   ├── repositories/         # Repositories for general features
│   │   ├── data/             # Data layer for general features
│   │   │   ├── datasources/  # Data sources
│   │   │   ├── models/       # Data models
│   │   │   └── repositories/  # Repositories for general features
│   │   ├── domain/           # Domain layer for general features
│   │   │   ├── entities/     # Domain entities
│   │   │   ├── repositories/  # Domain repositories
│   │   │   └── usecases/     # Use cases for general features
│   │   ├── presentation/      # Presentation layer for general features
│   │   │   ├── bloc/         # BLoC files for state management
│   │   │   │   ├── repository_bloc.dart
│   │   │   │   ├── repository_event.dart
│   │   │   │   └── repository_state.dart
│   │   │   ├── pages/        # Pages/screens related to repositories
│   │   │   ├── widgets/      # Widgets related to repository screens
│   │   └── injection/        # Dependency injection for repository features
├── main.dart                 # Entry point of the application
```
Getting Started
To get started with the User Management App, follow these steps:

Prerequisites
Flutter SDK
Dart SDK

Installation

Clone the repository:

git clone https://github.com/Serkouh-Abderrahmane/CodeExemple

Navigate to the project directory:

cd Abderrahmane-acote/CodeExemple

Install dependencies:

flutter pub get

Run the application:

flutter run

Build the App

To build the app for release, use the following command:

flutter build apk

Design Document

Key Design Decisions
Splash Screen: Designed to provide a visually appealing introduction to the application, showcasing brand elements and transitioning smoothly into the content.
State Management: The BLoC pattern is effective for managing complex states and separating business logic from the UI, making the application easier to scale and maintain.
UI/UX: The app provides a clean and modern interface while maintaining consistent colors and spacing. Detailed design elements are described in the attached document.
Performance: Ensures smooth performance and responsiveness with infinite scrolling and pull-to-refresh functionality. The DotLoadingWidget is used to provide a visually appealing loading indicator.
