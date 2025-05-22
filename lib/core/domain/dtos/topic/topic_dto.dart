class TopicDto {
  String id;
  String name;
  String? description;
  DateTime createAt;
  DateTime updateAt;
  bool isActive;
  String? parentTopicId;

  TopicDto({
    required this.id,
    required this.name,
    this.description,
    required this.createAt,
    required this.updateAt,
    required this.isActive,
    this.parentTopicId,
  });

  factory TopicDto.fromJson(Map<String, dynamic> json) {
    return TopicDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      createAt: DateTime.parse(json['createAt']),
      updateAt: DateTime.parse(json['updateAt']),
      isActive: json['isActive'] ?? false,
      parentTopicId: json['parentTopicId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'createAt': createAt.toIso8601String(),
    'updateAt': updateAt.toIso8601String(),
    'isActive': isActive,
    'parentTopicId': parentTopicId,
  };
}
