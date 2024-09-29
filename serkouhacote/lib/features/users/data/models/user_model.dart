class UserModel {
  final int id;
  final String name;
  final String avatarUrl;

  // Constructor for UserModel
  // Constructor cho UserModel
  UserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  // Factory method to create a UserModel from a JSON map
  // Phương thức factory để tạo UserModel từ một bản đồ JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // Get 'id' from JSON
      // Lấy 'id' từ JSON
      id: json['id'],
      // Get 'login' from JSON and use it as 'name'
      // Lấy 'login' từ JSON và sử dụng nó như 'name'
      name: json['login'],
      // Get 'avatar_url' from JSON
      // Lấy 'avatar_url' từ JSON
      avatarUrl: json['avatar_url'],
    );
  }
}
