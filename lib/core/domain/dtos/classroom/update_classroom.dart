class UpdateClassRoomDto {
  String id;
  String name;
  String? description;
  bool isPublic;

  UpdateClassRoomDto({
    required this.id,
    required this.name,
    this.description,
    required this.isPublic,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'isPublic': isPublic,
  };
}
