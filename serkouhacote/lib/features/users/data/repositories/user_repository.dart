import 'package:serkouhacote/core/network/NetworkInfo.dart';
import 'package:serkouhacote/core/utils/Failure.dart';
import 'package:serkouhacote/features/users/data/datasources/user_remote_data_source.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers(int page, int perPage);
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  // Constructor for UserRepositoryImpl
  // Constructor cho UserRepositoryImpl
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getUsers(int page, int perPage) async {
    // Check network connectivity
    // Kiểm tra kết nối mạng
    if (await networkInfo.isConnected) {
      try {
        // Fetch users from remote data source
        // Lấy người dùng từ nguồn dữ liệu từ xa
        final remoteUsers = await remoteDataSource.fetchUsers(page, perPage);

        // Convert the fetched data to a list of User entities and return it
        // Chuyển đổi dữ liệu đã lấy thành danh sách thực thể User và trả về
        return Right(
            remoteUsers.map((model) => User.fromModel(model)).toList());
      } catch (e) {
        // Handle any exceptions and return a NetworkFailure
        // Xử lý bất kỳ ngoại lệ nào và trả về NetworkFailure
        return Left(NetworkFailure('Failed to fetch users.'));
      }
    } else {
      // Return a NetworkFailure if there is no network connection
      // Trả về NetworkFailure nếu không có kết nối mạng
      return Left(NetworkFailure('No network connection.'));
    }
  }
}
