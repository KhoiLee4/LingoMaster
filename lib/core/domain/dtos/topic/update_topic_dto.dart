class UpdateTopicDto {
  String id;
  String name;
  String? description;
  bool isActive;
  String? parentTopicId;

  UpdateTopicDto({
    required this.id,
    required this.name,
    this.description,
    required this.isActive,
    this.parentTopicId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'isActive': isActive,
    'parentTopicId': parentTopicId,
  };
}
