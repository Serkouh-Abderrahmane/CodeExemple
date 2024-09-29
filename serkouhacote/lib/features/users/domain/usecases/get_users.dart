import 'package:serkouhacote/core/usescases/UseCase.dart';
import 'package:serkouhacote/core/utils/Failure.dart';
import 'package:serkouhacote/features/users/data/repositories/user_repository.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:dartz/dartz.dart';

// Use case for fetching a list of users
// Trường hợp sử dụng để lấy danh sách người dùng
class GetUsers {
  final UserRepository repository;

  // Constructor to initialize the UserRepository
  // Khởi tạo UserRepository
  GetUsers(this.repository);

  // Fetches a list of users from the repository with pagination
  // Lấy danh sách người dùng từ kho lưu trữ với phân trang
  Future<Either<Failure, List<User>>> call(int page, int perPage) async {
    return await repository.getUsers(page, perPage);
  }
}

// Parameters required for fetching users
// Các tham số cần thiết để lấy người dùng
class GetUsersParams {
  final int page;
  final int perPage;

  // Constructor to initialize the parameters
  // Khởi tạo các tham số
  GetUsersParams({required this.page, required this.perPage});
}
