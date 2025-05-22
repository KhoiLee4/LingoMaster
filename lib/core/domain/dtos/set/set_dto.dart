class SetDto {
  final String id;
  final String name;
  final String? description;
  final DateTime createAt;
  final DateTime updateAt;
  final String idTopic;

  SetDto({
    required this.id,
    required this.name,
    this.description,
    required this.createAt,
    required this.updateAt,
    required this.idTopic,
  });

  factory SetDto.fromJson(Map<String, dynamic> json) {
    return SetDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      createAt: json['createAt'] != null
          ? DateTime.parse(json['createAt'])
          : DateTime.now(),
      updateAt: json['updateAt'] != null
          ? DateTime.parse(json['updateAt'])
          : DateTime.now(),
      idTopic: json['idTopic'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createAt': createAt.toIso8601String(),
      'updateAt': updateAt.toIso8601String(),
      'idTopic': idTopic,
    };
  }

  @override
  String toString() {
    return 'SetDto(id: $id, name: $name, description: $description, createAt: $createAt, updateAt: $updateAt, idTopic: $idTopic)';
  }
}
