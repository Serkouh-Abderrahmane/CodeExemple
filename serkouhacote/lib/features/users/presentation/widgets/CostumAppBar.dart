import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// CustomAppBar is a customizable AppBar widget
// CustomAppBar là một widget AppBar có thể tùy chỉnh
class CostumAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Constructor to initialize the AppBar with a title and optional background color
  // Hàm khởi tạo để khởi tạo AppBar với tiêu đề và màu nền tùy chọn
  CostumAppBar({super.key, required this.title, Color? color})
      : color = color ?? Colors.green.shade50;

  final String title; // Tiêu đề hiển thị trong AppBar
  final Color color; // Màu nền của AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color, // Đặt màu nền của AppBar
      scrolledUnderElevation: 0.2, // Độ cao khi AppBar bị cuộn xuống dưới
      shadowColor: Colors.green.shade50, // Màu bóng của AppBar
      elevation: 0, // Độ cao của AppBar
      title: Text(title), // Đặt tiêu đề của AppBar
      leading: Container(
        margin: const EdgeInsets.all(5), // Khoảng cách xung quanh nút quay lại
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Biểu tượng cho nút quay lại
            color: Colors.white, // Màu của biểu tượng nút quay lại
          ),
          onPressed: () {
            GoRouter.of(context)
                .pop(); // Điều hướng quay lại khi nút quay lại được nhấn
          },
          color: Colors.black, // Màu của nút quay lại
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(56); // Chiều cao ưa thích của AppBar
}
