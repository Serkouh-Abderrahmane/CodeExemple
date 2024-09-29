import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serkouhacote/core/utils/Failure.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_users.dart';
import 'package:serkouhacote/features/users/presentation/bloc/userevent.dart';
import 'user_state.dart';

// Bloc class to handle user-related events and states
// Lớp Bloc để xử lý các sự kiện và trạng thái liên quan đến người dùng
class UserBloc extends Bloc<UserEvent, UserState> {
  static const int _perPage = 30; // Number of users per page
  // Số lượng người dùng trên mỗi trang
  int _page = 1; // Current page
  // Trang hiện tại
  bool _hasMore = true; // Flag to indicate if more users are available
  // Cờ để chỉ ra xem có thêm người dùng hay không
  List<User> _users = []; // List to hold users
  // Danh sách để lưu trữ người dùng
  final GetUsers getUsers;

  // Constructor for UserBloc
  // Khởi tạo UserBloc
  UserBloc({required this.getUsers}) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers); // Handle LoadUsers event
    // Xử lý sự kiện LoadUsers
    on<LoadMoreUsers>(_onLoadMoreUsers); // Handle LoadMoreUsers event
    // Xử lý sự kiện LoadMoreUsers
  }

  // Method to handle LoadUsers event
  // Phương thức để xử lý sự kiện LoadUsers
  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    _page = 1; // Reset to the first page
    _hasMore = true; // Reset the flag to indicate more users may be available
    _users = []; // Clear the existing user list
    await _fetchUsers(emit); // Fetch users and emit states
    // Lấy thông tin người dùng và phát ra trạng thái
  }

  // Method to handle LoadMoreUsers event
  // Phương thức để xử lý sự kiện LoadMoreUsers
  Future<void> _onLoadMoreUsers(
      LoadMoreUsers event, Emitter<UserState> emit) async {
    if (_hasMore) {
      _page++; // Increment the page number
      await _fetchUsers(emit); // Fetch more users and emit states
      // Lấy thêm thông tin người dùng và phát ra trạng thái
    }
  }

  // Method to fetch users from the repository
  // Phương thức để lấy người dùng từ kho lưu trữ
  Future<void> _fetchUsers(Emitter<UserState> emit) async {
    if (_page == 1) {
      emit(UserLoading()); // Emit loading state if it's the first page
      // Phát ra trạng thái đang tải nếu đây là trang đầu tiên
    }
    try {
      final failureOrUsers = await getUsers(_page, _perPage);
      // Lấy người dùng bằng cách sử dụng trường hợp sử dụng GetUsers
      // Sử dụng GetUsers để lấy thông tin người dùng
      failureOrUsers.fold(
        (failure) => emit(UserError(failure.message)),
        (users) {
          _hasMore =
              users.length == _perPage; // Check if more users are available
          // Kiểm tra xem có thêm người dùng hay không
          if (_page == 1) {
            _users = users; // Replace the user list if it's the first page
            // Thay thế danh sách người dùng nếu đây là trang đầu tiên
          } else {
            _users.addAll(users); // Append new users to the existing list
            // Thêm người dùng mới vào danh sách hiện tại
          }
          emit(UserLoaded(users: List.from(_users), hasMore: _hasMore));
          // Emit loaded state with the updated user list and availability flag
          // Phát ra trạng thái đã tải với danh sách người dùng được cập nhật và cờ khả dụng
        },
      );
    } catch (e) {
      emit(UserError(
          "Failed to fetch users.")); // Emit error state if an exception occurs
      // Phát ra trạng thái lỗi nếu có ngoại lệ xảy ra
    }
  }
}
