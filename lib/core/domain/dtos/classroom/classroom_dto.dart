class ClassRoomDto {
  String id;
  String name;
  String classCode;
  String? description;
  bool isDelete;
  bool isPublic;
  DateTime createdAt;
  DateTime updatedAt;

  ClassRoomDto({
    required this.id,
    required this.name,
    required this.classCode,
    this.description,
    required this.isDelete,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClassRoomDto.fromJson(Map<String, dynamic> json) {
    return ClassRoomDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      classCode: json['classCode'] ?? '',
      description: json['description'],
      isDelete: json['isDelete'] ?? false,
      isPublic: json['isPublic'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(), // hoặc null nếu field có thể null
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(), // hoặc null nếu field có thể null
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'classCode': classCode,
    'description': description,
    'isDelete': isDelete,
    'isPublic': isPublic,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
