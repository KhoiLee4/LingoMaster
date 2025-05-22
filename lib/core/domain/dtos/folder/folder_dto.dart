class FolderDto {
  String id;           // Guid ở Dart lưu dưới dạng String
  String name;
  bool isDeleted;
  DateTime createAt;
  DateTime updateAt;

  FolderDto({
    required this.id,
    required this.name,
    required this.isDeleted,
    required this.createAt,
    required this.updateAt,
  });

  // Factory tạo object từ JSON map
  factory FolderDto.fromJson(Map<String, dynamic> json) {
    return FolderDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createAt: json['createAt'] != null ? DateTime.parse(json['createAt']) : DateTime.now(),
      updateAt: json['updateAt'] != null ? DateTime.parse(json['updateAt']) : DateTime.now(),
    );
  }

  // Hàm convert object về JSON map
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'isDeleted': isDeleted,
    'createAt': createAt.toIso8601String(),
    'updateAt': updateAt.toIso8601String(),
  };
}