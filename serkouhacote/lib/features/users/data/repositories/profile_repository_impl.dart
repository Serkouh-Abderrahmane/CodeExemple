import 'package:serkouhacote/features/users/data/datasources/profile_remote_data_source.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  // Constructor for ProfileRepositoryImpl
  // Constructor cho ProfileRepositoryImpl
  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> getUser(String userName) async {
    // Fetch user data from remote data source
    // Lấy dữ liệu người dùng từ nguồn dữ liệu từ xa
    final userModel = await remoteDataSource.fetchUser(userName);

    // Map the fetched UserModel to User entity
    // Chuyển đổi UserModel đã lấy thành thực thể User
    return User(
      id: userModel.id,
      name: userModel.name,
      avatarUrl: userModel.avatarUrl,
    );
  }

  @override
  Future<List<Repository>> getRepositories(String userName) async {
    // Fetch repository data from remote data source
    // Lấy dữ liệu kho từ nguồn dữ liệu từ xa
    final repositoryModels = await remoteDataSource.fetchRepositories(userName);

    // Map the fetched list of RepositoryModel to a list of Repository entities
    // Chuyển đổi danh sách RepositoryModel đã lấy thành danh sách thực thể Repository
    return repositoryModels
        .map((model) => Repository(
              name: model.name,
              description: model.description,
              stargazersCount: model.stargazersCount,
              language: model.language,
            ))
        .toList();
  }
}
