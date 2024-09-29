import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:go_router/go_router.dart';
import 'package:serkouhacote/features/splash/presentation/pages/SplashScrean.dart';
import 'package:serkouhacote/features/splash/presentation/bloc/splashBlock.dart'; // Adjust import as needed
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'dart:async'; // Import for StreamController

// Mock class for SplashBloc
// Lớp giả lập cho SplashBloc
class MockSplashBloc extends Mock implements SplashBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'SplashScreen shows animation and navigates to home when SplashCompleted state is emitted',
      (WidgetTester tester) async {
    // Create a mock SplashBloc
    // Tạo một SplashBloc giả lập.
    final mockSplashBloc = MockSplashBloc();
    final streamController = StreamController<SplashState>();

    // Define the SplashCompleted state
    // Định nghĩa trạng thái SplashCompleted.
    final splashCompletedState = SplashCompleted();

    // Use StreamController to simulate the bloc stream
    // Sử dụng StreamController để mô phỏng luồng bloc.
    when(mockSplashBloc.stream).thenAnswer((_) => streamController.stream);
    when(mockSplashBloc.state).thenReturn(SplashInitial()); // Initial state
    // Thiết lập trạng thái ban đầu.

    // Build the widget tree
    // Xây dựng cây widget.
    await tester.pumpWidget(
      MaterialApp.router(
        routerDelegate: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => BlocProvider<SplashBloc>.value(
                value: mockSplashBloc,
                child: SplashScreen(),
              ),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => Scaffold(body: Text('Home Page')),
            ),
          ],
        ).routerDelegate,
        routeInformationParser: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => BlocProvider<SplashBloc>.value(
                value: mockSplashBloc,
                child: SplashScreen(),
              ),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => Scaffold(body: Text('Home Page')),
            ),
          ],
        ).routeInformationParser,
        theme: ThemeData(useMaterial3: false),
      ),
    );

    // Simulate state change
    // Mô phỏng sự thay đổi trạng thái.
    await Future.delayed(Duration(milliseconds: 100));
    streamController.add(splashCompletedState);

    // Verify if the Lottie animation is displayed initially
    // Xác minh xem liệu hoạt hình Lottie có hiển thị ban đầu hay không.
    expect(find.byType(Lottie), findsOneWidget);

    // Allow the widget to process state changes and navigation
    // Cho phép widget xử lý sự thay đổi trạng thái và điều hướng.
    await tester.pump(); // Initial pump to build the widget
    await tester
        .pumpAndSettle(); // Ensure all animations and navigation complete

    // Verify navigation to the home page
    // Xác minh điều hướng đến trang chính.
    expect(find.text('Home Page'), findsOneWidget);

    // Clean up
    // Dọn dẹp.
    await streamController.close();
  });
}
