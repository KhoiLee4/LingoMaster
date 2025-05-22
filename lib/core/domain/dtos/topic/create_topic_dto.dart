class CreateTopicDto {
  String name;
  String? description;
  String? parentTopicId;

  CreateTopicDto({
    required this.name,
    this.description,
    this.parentTopicId,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'parentTopicId': parentTopicId,
  };
}
