import 'package:serkouhacote/features/users/domain/entities/Users.dart';

// Abstract class representing the base state for user-related operations
// Lớp trừu tượng đại diện cho trạng thái cơ bản cho các thao tác liên quan đến người dùng
abstract class UserState {}

// Represents the initial state when the UserBloc is first created
// Đại diện cho trạng thái ban đầu khi UserBloc được tạo
class UserInitial extends UserState {}

// Represents the loading state when user data is being fetched
// Đại diện cho trạng thái đang tải khi dữ liệu người dùng đang được lấy
class UserLoading extends UserState {}

// Represents the state when user data has been successfully loaded
// Đại diện cho trạng thái khi dữ liệu người dùng đã được tải thành công
class UserLoaded extends UserState {
  final List<User> users; // List of users that have been fetched
  // Danh sách người dùng đã được lấy
  final bool hasMore; // Indicates if there are more users to load
  // Chỉ ra xem có thêm người dùng để tải hay không

  UserLoaded({required this.users, required this.hasMore});
}

// Represents an error state when there is a failure in fetching user data
// Đại diện cho trạng thái lỗi khi có sự cố trong việc lấy dữ liệu người dùng
class UserError extends UserState {
  final String message; // Error message describing the issue
  // Thông điệp lỗi mô tả vấn đề

  UserError(this.message);
}
