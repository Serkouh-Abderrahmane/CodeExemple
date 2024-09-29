import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_profile.dart';

// Define events
// Định nghĩa các sự kiện
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String userName;
  LoadProfile(this.userName);
}

// Define states
// Định nghĩa các trạng thái
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final List<Repository> repositories;

  // Constructor for ProfileLoaded state
  // Khởi tạo trạng thái ProfileLoaded
  ProfileLoaded(this.user, this.repositories);
}

class ProfileError extends ProfileState {
  final String message;

  // Constructor for ProfileError state
  // Khởi tạo trạng thái ProfileError
  ProfileError(this.message);
}

// Bloc to handle profile-related events and states
// Bloc để xử lý các sự kiện và trạng thái liên quan đến hồ sơ
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  // Constructor to initialize the repository
  // Khởi tạo kho lưu trữ
  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile); // Handle LoadProfile event
    // Xử lý sự kiện LoadProfile
  }

  // Method to handle LoadProfile event
  // Phương thức để xử lý sự kiện LoadProfile
  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading()); // Emit loading state
    // Phát ra trạng thái đang tải
    try {
      final user = await repository.getUser(event.userName);
      final repositories = await repository.getRepositories(event.userName);
      emit(ProfileLoaded(
          user, repositories)); // Emit loaded state with user and repositories
      // Phát ra trạng thái đã tải với người dùng và kho lưu trữ
    } catch (e) {
      emit(ProfileError(
          "An error occurred: $e")); // Emit error state if exception occurs
      // Phát ra trạng thái lỗi nếu có ngoại lệ xảy ra
    }
  }
}
