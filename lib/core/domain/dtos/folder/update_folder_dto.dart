class UpdateFolderDto {
  final String id;
  final String name;
  final bool isDeleted;

  UpdateFolderDto({
    required this.id,
    required this.name,
    this.isDeleted = false,
  });

  factory UpdateFolderDto.fromJson(Map<String, dynamic> json) {
    return UpdateFolderDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isDeleted': isDeleted,
    };
  }
}