class UpdateSetDto {
  final String id;
  final String name;
  final String? description;
  final String idTopic;

  UpdateSetDto({
    required this.id,
    required this.name,
    this.description,
    required this.idTopic,
  });

  factory UpdateSetDto.fromJson(Map<String, dynamic> json) {
    return UpdateSetDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      idTopic: json['idTopic'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'idTopic': idTopic,
    };
  }

  @override
  String toString() {
    return 'UpdateSetDto(id: $id, name: $name, description: $description, idTopic: $idTopic)';
  }
}