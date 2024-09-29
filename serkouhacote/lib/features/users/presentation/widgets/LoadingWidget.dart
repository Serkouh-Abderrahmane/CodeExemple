import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:serkouhacote/core/theme/Colors.dart'; // Import the custom color theme

/// A widget that displays a dot-based loading animation.
/// Một widget hiển thị hoạt hình tải dựa trên chấm.
class DotLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return JumpingDots(
      color: AppColors.primaryBlack, // Use primary black color from theme.
      // Sử dụng màu đen chính từ chủ đề.
      radius: 10, // Set the size of each dot.
      // Đặt kích thước của mỗi chấm.
      numberOfDots: 3, // Number of dots to display in the animation.
      // Số lượng chấm hiển thị trong hoạt hình.
      animationDuration:
          Duration(milliseconds: 200), // Duration for the bouncing animation.
      // Thời gian cho hoạt hình nảy.
    );
  }
}
