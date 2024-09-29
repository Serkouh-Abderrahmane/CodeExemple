// Represents a general failure.
// Đại diện cho một lỗi chung.
class Failure {
  // Error message.
  // Thông điệp lỗi.
  final String message;

  // Constructor.
  // Hàm khởi tạo.
  Failure(this.message);
}

// Represents a network-related failure.
// Đại diện cho một lỗi liên quan đến mạng.
class NetworkFailure extends Failure {
  // Constructor.
  // Hàm khởi tạo.
  NetworkFailure(String message) : super(message);
}
