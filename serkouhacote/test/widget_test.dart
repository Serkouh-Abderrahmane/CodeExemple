import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_users.dart';
import 'package:serkouhacote/features/users/presentation/bloc/user_bloc.dart';
import 'package:serkouhacote/features/users/presentation/bloc/user_state.dart';
import 'package:serkouhacote/features/users/presentation/bloc/userevent.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/presentation/pages/Home.dart';
import 'package:serkouhacote/features/users/presentation/widgets/AdvertWidget.dart';

// Định nghĩa lớp Mock (Mock classes)
class MockGetUsers extends Mock implements GetUsers {}

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  late MockUserBloc mockUserBloc;
  late MockGetUsers mockGetUsers;

  // Thiết lập môi trường kiểm tra (Set up the test environment)
  setUp(() {
    mockUserBloc = MockUserBloc();
    mockGetUsers = MockGetUsers();
  });

  // Tạo widget để kiểm tra (Create the widget under test)
  Widget createWidgetUnderTest() {
    return BlocProvider<UserBloc>(
      create: (context) => mockUserBloc,
      child: MaterialApp(home: Home()),
    );
  }

  // Kiểm tra xem có hiển thị widget loading khi phát ra trạng thái UserLoading không (Should display loading widget when UserLoading state is emitted)
  testWidgets('should display loading widget when UserLoading state is emitted',
      (WidgetTester tester) async {
    // Sắp xếp
    // Thiết lập để trả về trạng thái UserLoading (Set up to return UserLoading state)
    when(mockUserBloc.state).thenReturn(UserLoading());

    // Hành động
    // Tiêm widget vào môi trường kiểm tra (Inject widget into the test environment)
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Kích hoạt một khung (Trigger a frame)

    // Kiểm tra
    // Kiểm tra xem CircularProgressIndicator có được hiển thị không (Verify that CircularProgressIndicator is displayed)
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // Kiểm tra xem có hiển thị thông báo lỗi khi phát ra trạng thái UserError không (Should display error message when UserError state is emitted)
  testWidgets('should display error message when UserError state is emitted',
      (WidgetTester tester) async {
    // Sắp xếp
    // Thiết lập để trả về trạng thái UserError (Set up to return UserError state)
    when(mockUserBloc.state).thenReturn(UserError('Đã xảy ra lỗi'));

    // Hành động
    // Tiêm widget vào môi trường kiểm tra (Inject widget into the test environment)
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Kích hoạt một khung (Trigger a frame)

    // Kiểm tra
    // Kiểm tra xem thông báo lỗi có được hiển thị không (Verify that the error message is displayed)
    expect(find.text('Đã xảy ra lỗi'), findsOneWidget);
  });

  // Kiểm tra xem có hiển thị danh sách người dùng khi phát ra trạng thái UserLoaded không (Should display list of users when UserLoaded state is emitted)
  testWidgets('should display list of users when UserLoaded state is emitted',
      (WidgetTester tester) async {
    // Sắp xếp
    final users = [
      User(
          id: 1,
          name: 'Người dùng 1',
          avatarUrl: 'http://example.com/user1.jpg'),
      User(
          id: 2,
          name: 'Người dùng 2',
          avatarUrl: 'http://example.com/user2.jpg'),
    ];
    // Thiết lập để trả về trạng thái UserLoaded với người dùng (Set up to return UserLoaded state with users)
    when(mockUserBloc.state)
        .thenReturn(UserLoaded(users: users, hasMore: false));

    // Hành động
    // Tiêm widget vào môi trường kiểm tra (Inject widget into the test environment)
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Kích hoạt một khung (Trigger a frame)

    // Kiểm tra
    // Kiểm tra xem danh sách người dùng có được hiển thị không (Verify that the list of users is displayed)
    expect(find.text('Người dùng 1'), findsOneWidget);
    expect(find.text('Người dùng 2'), findsOneWidget);
  });

  // Kiểm tra xem có hiển thị widget quảng cáo có thể nhấp mỗi 10 người dùng không (Should display a clickable ad widget every 10 users)
  testWidgets('should display a clickable ad widget every 10 users',
      (WidgetTester tester) async {
    // Sắp xếp
    final users = List.generate(
      20,
      (index) => User(
          id: index,
          name: 'Người dùng $index',
          avatarUrl: 'http://example.com/user$index.jpg'),
    );
    // Thiết lập để trả về trạng thái UserLoaded với 20 người dùng (Set up to return UserLoaded state with 20 users)
    when(mockUserBloc.state)
        .thenReturn(UserLoaded(users: users, hasMore: false));

    // Hành động
    // Tiêm widget vào môi trường kiểm tra (Inject widget into the test environment)
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Kích hoạt một khung (Trigger a frame)

    // Kiểm tra
    // Kiểm tra xem widget Clickable_AD_Image có được hiển thị không (Verify that Clickable_AD_Image widget is displayed)
    expect(find.byType(Clickable_AD_Image), findsOneWidget);
  });

  // Kiểm tra xem sự kiện LoadUsers có được gọi khi nhấn nút FloatingActionButton không (Should call LoadUsers event when floating action button is pressed)
  testWidgets(
      'should call LoadUsers event when floating action button is pressed',
      (WidgetTester tester) async {
    // Sắp xếp
    // Thiết lập để trả về trạng thái UserLoaded với không người dùng (Set up to return UserLoaded state with no users)
    when(mockUserBloc.state).thenReturn(UserLoaded(users: [], hasMore: false));

    // Hành động
    // Tiêm widget vào môi trường kiểm tra (Inject widget into the test environment)
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Kích hoạt một khung (Trigger a frame)

    final fabFinder = find.byType(FloatingActionButton);
    expect(fabFinder, findsOneWidget);

    // Nhấn nút FloatingActionButton (Tap the FloatingActionButton)
    await tester.tap(fabFinder);
    await tester.pump(); // Xây dựng lại widget (Rebuild the widget)

    // Kiểm tra
    // Kiểm tra xem sự kiện LoadUsers có được gọi không (Verify that LoadUsers event is called)
    verify(mockUserBloc.add(LoadUsers())).called(1);
  });
}
