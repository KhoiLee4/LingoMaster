  class SetDto {
    final String id;
    final String name;
    final String? description;
    final String topicId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int? cardCount;

    SetDto({
      required this.id,
      required this.name,
      this.description,
      required this.topicId,
      required this.createdAt,
      required this.updatedAt,
      this.cardCount,
    });

    factory SetDto.fromJson(Map<String, dynamic> json) {
      return SetDto(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        topicId: json['topicId'],
        createdAt: DateTime.parse(json['createdAt'] ?? json['createAt']),
        updatedAt: DateTime.parse(json['updatedAt'] ?? json['updateAt']),
        cardCount: json['cardCount'],
      );
    }

    Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'description': description,
      'topicId': topicId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'cardCount': cardCount,
    };
  }

  class CreateSetDto {
    final String name;
    final String? description;
    final String topicId;

    CreateSetDto({
      required this.name,
      this.description,
      required this.topicId,
    });

    Map<String, dynamic> toJson() => {
      'name': name,
      'description': description,
      'topicId': topicId,
    };
  }

  class UpdateSetDto {
    final String id;
    final String name;
    final String? description;
    final String topicId;

    UpdateSetDto({
      required this.id,
      required this.name,
      this.description,
      required this.topicId,
    });

    Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'description': description,
      'topicId': topicId,
    };
  }