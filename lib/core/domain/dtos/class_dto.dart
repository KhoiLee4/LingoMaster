// File: lib/core/domain/dtos/classroom_dto.dart
class ClassRoomDto {
  final String id;
  final String className;
  final String description;
  final String classCode;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isDeleted;

  ClassRoomDto({
    required this.id,
    required this.className,
    required this.description,
    required this.classCode,
    required this.createdBy,
    required this.createdAt,
    this.updatedAt,
    required this.isDeleted,
  });

  factory ClassRoomDto.fromJson(Map<String, dynamic> json) {
    return ClassRoomDto(
      id: json['id'],
      className: json['className'],
      description: json['description'] ?? '',
      classCode: json['classCode'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'className': className,
      'description': description,
      'classCode': classCode,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isDeleted': isDeleted,
    };
  }
}

// File: lib/core/domain/dtos/create_classroom_dto.dart

class CreateClassRoomDto {
  final String className;
  final String description;
  String? classCode;
  final String createdBy;

  CreateClassRoomDto({
    required this.className,
    required this.description,
    this.classCode,
    required this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'className': className,
      'description': description,
      'classCode': classCode,
      'createdBy': createdBy,
    };
  }
}

// File: lib/core/domain/dtos/update_classroom_dto.dart
class UpdateClassRoomDto {
  final String id;
  final String className;
  final String description;

  UpdateClassRoomDto({
    required this.id,
    required this.className,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'className': className,
      'description': description,
    };
  }
}