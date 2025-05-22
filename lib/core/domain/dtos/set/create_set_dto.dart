class CreateSetDto {
  final String name;
  final String? description;
  final String idTopic;

  CreateSetDto({
    required this.name,
    this.description,
    required this.idTopic,
  });

  factory CreateSetDto.fromJson(Map<String, dynamic> json) {
    return CreateSetDto(
      name: json['name'] ?? '',
      description: json['description'],
      idTopic: json['idTopic'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'idTopic': idTopic,
    };
  }

  @override
  String toString() {
    return 'CreateSetDto(name: $name, description: $description, idTopic: $idTopic)';
  }
}