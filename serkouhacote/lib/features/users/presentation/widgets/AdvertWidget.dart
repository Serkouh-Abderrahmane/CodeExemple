import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Clickable_AD_Image widget displays an image that, when tapped, opens a URL
// Widget Clickable_AD_Image hiển thị một hình ảnh mà khi chạm vào, sẽ mở một URL
class Clickable_AD_Image extends StatelessWidget {
  final String imageUrl; // URL của hình ảnh để hiển thị
  final String link; // URL để mở khi hình ảnh được chạm vào

  // Constructor to initialize imageUrl and link
  // Hàm khởi tạo để khởi tạo imageUrl và link
  const Clickable_AD_Image({
    required this.imageUrl,
    required this.link,
  });

  // Method to launch the URL in a web browser
  // Phương thức để mở URL trong trình duyệt web
  Future<void> _launchURL() async {
    try {
      final Uri uri = Uri.parse(link); // Phân tích URL
      await launchUrl(uri); // Mở URL
    } catch (e) {
      _showError(
          "An error occurred while launching the URL."); // Hiển thị lỗi nếu mở URL thất bại
    }
  }

  // Method to show an error message
  // Phương thức để hiển thị thông điệp lỗi
  void _showError(String message) {
    // Bạn có thể sử dụng SnackBar, AlertDialog hoặc bất kỳ phương pháp nào khác để hiển thị thông điệp lỗi
    // Bạn có thể sử dụng SnackBar, AlertDialog hoặc bất kỳ phương pháp nào khác để hiển thị thông điệp lỗi
    print(message); // Đây chỉ là để mục đích gỡ lỗi
    // Đây chỉ là để mục đích gỡ lỗi
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(); // Mở URL khi hình ảnh được chạm vào
      },
      child: Container(
        width: double.infinity, // Chiều rộng đầy đủ của container cha
        height: 150, // Chiều cao cố định cho container hình ảnh
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl), // Tải hình ảnh từ mạng
            fit: BoxFit.cover, // Đảm bảo hình ảnh bao phủ toàn bộ container
          ),
        ),
      ),
    );
  }
}
