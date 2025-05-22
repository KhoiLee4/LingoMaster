class CreateFolderDto {
  final String name;

  CreateFolderDto({
    required this.name,
  });

  factory CreateFolderDto.fromJson(Map<String, dynamic> json) {
    return CreateFolderDto(
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}