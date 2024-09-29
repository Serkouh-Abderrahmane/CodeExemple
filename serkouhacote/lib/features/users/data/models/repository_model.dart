class RepositoryModel {
  final String name;
  final String description;
  final int stargazersCount;
  final String language;

  // Constructor for RepositoryModel
  // Constructor cho RepositoryModel
  RepositoryModel({
    required this.name,
    required this.description,
    required this.stargazersCount,
    required this.language,
  });

  // Factory method to create a RepositoryModel from a JSON map
  // Phương thức factory để tạo RepositoryModel từ một bản đồ JSON
  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      // Get 'name' from JSON or use 'No name' if it's missing
      // Lấy 'name' từ JSON hoặc sử dụng 'No name' nếu không có
      name: json['name'] ?? 'No name',
      // Get 'description' from JSON or use 'No description' if it's missing
      // Lấy 'description' từ JSON hoặc sử dụng 'No description' nếu không có
      description: json['description'] ?? 'No description',
      // Get 'stargazers_count' from JSON or use 0 if it's missing
      // Lấy 'stargazers_count' từ JSON hoặc sử dụng 0 nếu không có
      stargazersCount: json['stargazers_count'] ?? 0,
      // Get 'language' from JSON or use 'Unknown' if it's missing
      // Lấy 'language' từ JSON hoặc sử dụng 'Unknown' nếu không có
      language: json['language'] ?? 'Unknown',
    );
  }
}
