import 'package:dio/dio.dart';
import 'package:serkouhacote/core/utils/Urls.dart';
import 'package:serkouhacote/features/users/data/models/user_model.dart';

// Định nghĩa lớp trừu tượng cho nguồn dữ liệu người dùng
// Define the abstract class for user data source
abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchUsers(int page, int perPage);
}

// Thực hiện UserRemoteDataSource sử dụng Dio
// Implement the UserRemoteDataSource using Dio
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UserModel>> fetchUsers(int page, int perPage) async {
    try {
      // Lấy dữ liệu người dùng từ API với phân trang
      // Fetch user data from the API with pagination
      final response = await dio.get(
        '$mainurl',
        queryParameters: {'per_page': perPage, 'page': page},
      );
      // Phân tích dữ liệu phản hồi thành danh sách các đối tượng UserModel
      // Parse the response data into a list of UserModel objects
      final List<dynamic> data = response.data;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      // Xử lý bất kỳ ngoại lệ nào xảy ra trong quá trình gọi API
      // Handle any exceptions that occur during the API call
      throw Exception('Không thể tải người dùng: $e');
      // throw Exception('Failed to load users: $e');
    }
  }
}
