class CreateClassRoomDto {
  String name;
  String? classCode;
  String? description;
  bool isPublic;

  CreateClassRoomDto({
    required this.name,
    this.classCode,
    this.description,
    this.isPublic = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'classCode': classCode,
    'description': description,
    'isPublic': isPublic,
  };
}
