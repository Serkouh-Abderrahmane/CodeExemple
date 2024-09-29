import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;

  // Constructor to initialize the ProfileRepository
  // Khởi tạo ProfileRepository
  GetProfile(this.repository);

  // Retrieves the user profile information based on the provided username
  // Lấy thông tin hồ sơ người dùng dựa trên tên người dùng đã cung cấp
  Future<User> call(String userName) async {
    return await repository.getUser(userName);
  }

  // Retrieves a list of repositories for the given username
  // Lấy danh sách kho lưu trữ cho tên người dùng đã cho
  Future<List<Repository>> callRepositories(String userName) async {
    return await repository.getRepositories(userName);
  }
}
