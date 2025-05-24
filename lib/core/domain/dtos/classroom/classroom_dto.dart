class ClassRoomDto {
  String id;
  String name;
  String classCode;
  String? description;
  bool isDelete;
  bool isPublic;
  DateTime? createdAt; // Thay đổi thành nullable
  DateTime? updatedAt; // Thay đổi thành nullable

  ClassRoomDto({
    required this.id,
    required this.name,
    required this.classCode,
    this.description,
    required this.isDelete,
    required this.isPublic,
    this.createdAt, // Không bắt buộc
    this.updatedAt, // Không bắt buộc
  });

  factory ClassRoomDto.fromJson(Map<String, dynamic> json) {
    return ClassRoomDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      classCode: json['classCode'] ?? '',
      description: json['description'],
      isDelete: json['isDelete'] ?? false,
      isPublic: json['isPublic'] ?? false,
      // Kiểm tra null trước khi parse DateTime
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'classCode': classCode,
    'description': description,
    'isDelete': isDelete,
    'isPublic': isPublic,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}