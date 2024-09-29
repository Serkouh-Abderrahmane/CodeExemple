import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';

abstract class ProfileRepository {
  // Fetches a user based on the username
  // Lấy người dùng dựa trên tên người dùng
  Future<User> getUser(String userName);

  // Fetches a list of repositories for the given username
  // Lấy danh sách kho lưu trữ cho tên người dùng đã cho
  Future<List<Repository>> getRepositories(String userName);
}
