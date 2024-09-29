// Abstract class representing the base event for user-related actions
// Lớp trừu tượng đại diện cho sự kiện cơ bản cho các hành động liên quan đến người dùng
abstract class UserEvent {}

// Event indicating that a request to load the initial set of users has been made
// Sự kiện cho biết rằng một yêu cầu để tải danh sách người dùng ban đầu đã được thực hiện
class LoadUsers extends UserEvent {}

// Event indicating that a request to load more users (pagination) has been made
// Sự kiện cho biết rằng một yêu cầu để tải thêm người dùng (phân trang) đã được thực hiện
class LoadMoreUsers extends UserEvent {}
