import 'package:serkouhacote/core/utils/Urls.dart';
import 'package:serkouhacote/features/users/data/models/repository_model.dart';
import 'package:serkouhacote/features/users/data/models/user_model.dart';
import 'package:dio/dio.dart';

// Định nghĩa lớp trừu tượng cho nguồn dữ liệu hồ sơ
// Define the abstract class for profile data source
abstract class ProfileRemoteDataSource {
  Future<UserModel> fetchUser(String userName);
  Future<List<RepositoryModel>> fetchRepositories(String userName);
}

// Thực hiện ProfileRemoteDataSource sử dụng Dio
// Implement the ProfileRemoteDataSource using Dio
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> fetchUser(String userName) async {
    try {
      // Lấy dữ liệu người dùng từ API
      // Fetch user data from the API
      final response = await dio.get('$mainurl/$userName');
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Không thể tải người dùng');
        // throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Không thể tải người dùng: $e');
      // throw Exception('Failed to load user: $e');
    }
  }

  @override
  Future<List<RepositoryModel>> fetchRepositories(String userName) async {
    try {
      // Lấy dữ liệu kho lưu trữ từ API
      // Fetch repositories data from the API
      final response = await dio.get('$mainurl/$userName/repos');
      if (response.statusCode == 200) {
        final List<dynamic> repositoriesJson = response.data;
        return repositoriesJson
            .map((json) => RepositoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Không thể tải kho lưu trữ');
        // throw Exception('Failed to load repositories');
      }
    } catch (e) {
      throw Exception('Không thể tải kho lưu trữ: $e');
      // throw Exception('Failed to load repositories: $e');
    }
  }
}
