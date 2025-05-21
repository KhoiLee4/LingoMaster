// DTOs
class FolderDto {
  final String id;
  final String name;
  final String? description;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isDeleted;

  FolderDto({
    required this.id,
    required this.name,
    this.description,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
  });

  factory FolderDto.fromJson(Map<String, dynamic> json) {
    return FolderDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      userId: json['userId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isDeleted: json['isDeleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'userId': userId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isDeleted': isDeleted,
    };
  }
}

class CreateFolderDto {
  final String name;
  final String? description;
  final String? userId;

  CreateFolderDto({
    required this.name,
    this.description,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'userId': userId,
    };
  }
}

class UpdateFolderDto {
  final String id;
  final String name;
  final String? description;

  UpdateFolderDto({
    required this.id,
    required this.name,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}