import 'package:flutter/material.dart';
import 'package:serkouhacote/core/theme/Colors.dart';
import 'package:serkouhacote/core/theme/fontsize.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';

// CustomProfileHeader is a widget for displaying user profile information
// CustomProfileHeader là một widget để hiển thị thông tin hồ sơ người dùng
class CustomProfileHeader extends StatelessWidget {
  final User user; // Người dùng mà hồ sơ đang được hiển thị

  // Constructor to initialize the CustomProfileHeader with a User
  // Hàm khởi tạo để khởi tạo CustomProfileHeader với một người dùng
  const CustomProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Chiều rộng đầy đủ của container
      padding: const EdgeInsets.only(bottom: 4), // Khoảng cách ở phía dưới
      decoration: const BoxDecoration(
        color: Colors.white, // Màu nền của tiêu đề hồ sơ
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Căn giữa các phần tử theo chiều ngang
        mainAxisAlignment:
            MainAxisAlignment.center, // Căn giữa các phần tử theo chiều dọc
        children: [
          const SizedBox(height: 16), // Khoảng cách cho không gian dọc
          Stack(
            children: [
              CircleAvatar(
                radius: 45, // Bán kính của hình ảnh hồ sơ
                backgroundImage: NetworkImage(
                    user.avatarUrl), // Hiển thị avatar của người dùng
              ),
              Positioned(
                top: 0, // Đặt nút chỉnh sửa ở trên cùng
                right: 0, // Đặt nút chỉnh sửa ở bên phải
                child: GestureDetector(
                  onTap: () {
                    // TODO: Triển khai chức năng chỉnh sửa hồ sơ
                  },
                  child: const CircleAvatar(
                    backgroundColor:
                        AppColors.primaryWhite, // Màu nền của nút chỉnh sửa
                    radius: 14, // Bán kính của nút chỉnh sửa
                    child: Icon(Icons.edit,
                        color: AppColors.primaryBlack), // Biểu tượng chỉnh sửa
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8), // Khoảng cách cho không gian dọc
          Text(
            user.name, // Hiển thị tên của người dùng
            style: TextStyle(
              fontSize: FontSizes.x2Large, // Kích thước chữ cho tên người dùng
              fontWeight: FontWeight.bold, // Chữ đậm cho tên người dùng
              color: AppColors.secondarygrey, // Màu chữ cho tên người dùng
            ),
          ),
          const SizedBox(height: 16), // Khoảng cách cho không gian dọc
        ],
      ),
    );
  }
}
