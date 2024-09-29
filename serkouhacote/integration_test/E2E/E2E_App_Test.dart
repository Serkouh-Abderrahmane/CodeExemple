import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serkouhacote/features/splash/presentation/pages/SplashScrean.dart';
import 'package:serkouhacote/features/users/presentation/pages/Home.dart';
import 'package:serkouhacote/features/users/presentation/pages/profile_screen.dart';
import 'package:serkouhacote/features/users/presentation/widgets/AdvertWidget.dart';
import 'package:serkouhacote/features/users/presentation/widgets/LoadingWidget.dart';
import 'package:serkouhacote/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'Splash screen transitions to Home, and Home screen functionality works',
      (WidgetTester tester) async {
    // Launch the app and wait for the SplashScreen to show
    // Khởi động ứng dụng và chờ màn hình Splash hiển thị.
    app.main();
    await tester.pumpAndSettle(); // Wait for the app to settle
    // Chờ ứng dụng ổn định.

    // Verify SplashScreen and wait for it to transition to Home
    // Xác minh SplashScreen và chờ nó chuyển đến Home.
    expect(find.byType(SplashScreen), findsOneWidget);
    await tester.pumpAndSettle(); // Wait for transition
    // Chờ cho quá trình chuyển tiếp hoàn tất.

    // Ensure the Home screen is displayed
    // Đảm bảo màn hình Home hiển thị.
    expect(find.byType(Home), findsOneWidget);

    // Check if the loading indicator is displayed initially
    // Kiểm tra xem chỉ báo tải có hiển thị ban đầu không.
    expect(find.byType(DotLoadingWidget), findsOneWidget);

    // Simulate loading more users by scrolling
    // Mô phỏng việc tải thêm người dùng bằng cách cuộn.
    final scrollable = find.byType(Scrollable).first;
    await tester.drag(
        scrollable, Offset(0, -300)); // Scroll up to trigger loading more
    // Cuộn lên để kích hoạt tải thêm.
    await tester.pumpAndSettle(); // Wait for the loading to complete
    // Chờ cho việc tải hoàn tất.

    // Verify that user items are displayed in the list
    // Xác minh rằng các mục người dùng được hiển thị trong danh sách.
    expect(find.byType(ListTile), findsWidgets);

    // Verify the FloatingActionButton and click it to reload
    // Xác minh FloatingActionButton và nhấp vào nó để tải lại.
    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);
    await tester.tap(fab);
    await tester.pumpAndSettle(); // Wait for the reload to complete
    // Chờ cho việc tải lại hoàn tất.

    // Verify that an ad is displayed at the correct interval (every 10 items)
    // Xác minh rằng quảng cáo được hiển thị tại khoảng thời gian chính xác (mỗi 10 mục).
    expect(find.byType(Clickable_AD_Image),
        findsWidgets); // Check if ad is present
    // Kiểm tra xem quảng cáo có xuất hiện không.

    // Interact with a user item and check for navigation
    // Tương tác với một mục người dùng và kiểm tra điều hướng.
    final firstUser = find.byType(ListTile).first;
    await tester.tap(firstUser);
    await tester.pumpAndSettle(); // Wait for navigation to complete
    // Chờ cho việc điều hướng hoàn tất.

    // Ensure ProfileScreen is displayed
    // Đảm bảo rằng ProfileScreen hiển thị.
    expect(find.byType(ProfileScreen), findsOneWidget);

    // Optionally, verify some elements on the ProfileScreen if needed
    // Tùy chọn, xác minh một số phần tử trên ProfileScreen nếu cần.
    // For example:
    // expect(find.text('Profile'), findsOneWidget);
  });
}
