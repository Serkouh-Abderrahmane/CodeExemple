import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:serkouhacote/core/theme/Colors.dart';
import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_profile.dart';
import 'package:serkouhacote/features/users/presentation/bloc/profile_bloc.dart';
import 'package:serkouhacote/features/users/presentation/widgets/LoadingWidget.dart';
import 'package:serkouhacote/features/users/presentation/widgets/actions.dart';
import 'package:serkouhacote/features/users/presentation/widgets/custom_profile_header.dart';

// ProfileScreen displays a user's profile information
// ProfileScreen hiển thị thông tin hồ sơ của người dùng
class ProfileScreen extends StatelessWidget {
  final String userName;

  // Constructor to accept the username as a parameter
  // Hàm khởi tạo nhận tên người dùng dưới dạng tham số
  const ProfileScreen({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Get ProfileBloc instance from GetIt service locator
        // Lấy phiên bản ProfileBloc từ bộ định vị dịch vụ GetIt
        final bloc = GetIt.instance<ProfileBloc>();
        bloc.add(LoadProfile(userName)); // Trigger loading profile data
        // Kích hoạt việc tải dữ liệu hồ sơ
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: AppColors.primaryBlack, // AppBar color
          // Màu của AppBar
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              // Show loading widget when profile is loading
              // Hiển thị widget tải khi hồ sơ đang được tải
              return Center(child: DotLoadingWidget());
            } else if (state is ProfileLoaded) {
              // Display profile information and actions when profile is loaded
              // Hiển thị thông tin hồ sơ và các hành động khi hồ sơ đã được tải
              return Container(
                height: double.infinity,
                color: AppColors.primaryGray, // Background color
                // Màu nền
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12), // Spacing
                      CustomProfileHeader(
                          user: state.user), // Profile header widget
                      const SizedBox(height: 16), // Spacing
                      ActionsList(
                          repositories:
                              state.repositories), // Actions list widget
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              // Show error message if there is an error loading the profile
              // Hiển thị thông báo lỗi nếu có lỗi xảy ra khi tải hồ sơ
              return Center(child: Text(state.message));
            }
            // Display a fallback message for unexpected states
            // Hiển thị thông điệp dự phòng cho các trạng thái không mong đợi
            return Center(child: Text('Unexpected state'));
          },
        ),
      ),
    );
  }
}
