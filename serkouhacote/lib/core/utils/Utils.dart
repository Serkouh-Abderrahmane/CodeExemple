// Capitalizes the first letter of a string.
// Chuyển đổi ký tự đầu tiên của một chuỗi thành chữ hoa.
String capitalize(String s) {
  // Ensure string is not empty to avoid errors.
  // Đảm bảo chuỗi không trống để tránh lỗi.
  if (s.isEmpty) return s;

  // Capitalize the first letter and concatenate with the rest of the string.
  // Chuyển ký tự đầu tiên thành chữ hoa và kết hợp với phần còn lại của chuỗi.
  return s[0].toUpperCase() + s.substring(1);
}
