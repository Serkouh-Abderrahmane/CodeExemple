import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serkouhacote/features/splash/presentation/pages/SplashScrean.dart';
import 'package:serkouhacote/features/users/presentation/pages/Home.dart';
import 'package:serkouhacote/features/users/presentation/pages/profile_screen.dart';

// GoRouter instance to define the navigation structure
// Thể hiện GoRouter để định nghĩa cấu trúc điều hướng
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/', // Root path of the application
      // Builder to create the SplashScreen widget when the root path is accessed
      // Builder để tạo widget SplashScreen khi truy cập vào đường dẫn gốc
      builder: (context, state) => SplashScreen(),
      routes: [
        GoRoute(
            path: 'home', // Path for the home screen
            // Builder to create the Home widget when the 'home' path is accessed
            // Builder để tạo widget Home khi truy cập vào đường dẫn 'home'
            builder: (context, state) {
              return Home();
            },
            routes: [
              GoRoute(
                path:
                    'profile/:userName', // Path for user profile screen with userName parameter
                // Builder to create the ProfileScreen widget and pass the userName parameter
                // Builder để tạo widget ProfileScreen và truyền tham số userName
                builder: (context, state) {
                  final userName = state.pathParameters[
                      'userName']!; // Extract userName from path parameters
                  return ProfileScreen(
                      userName: userName); // Pass userName to ProfileScreen
                },
              ),
            ]),
      ],
    ),
  ],
  errorBuilder: (context, state) {
    // Builder to handle errors, displaying an error message
    // Builder để xử lý lỗi, hiển thị một thông báo lỗi
    return Scaffold(
      body: Center(
          child: Text(
              'Error: ${state.error}')), // Display error message in the center
      // Hiển thị thông báo lỗi ở giữa
    );
  },
);
