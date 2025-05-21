// File: lib/core/domain/dtos/card_dto.dart
class CardDto {
  final String id;
  final String frontContent;
  final String backContent;
  final String? imageUrl;
  final String? audioUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CardDto({
    required this.id,
    required this.frontContent,
    required this.backContent,
    this.imageUrl,
    this.audioUrl,
    required this.createdAt,
    this.updatedAt,
  });

  factory CardDto.fromJson(Map<String, dynamic> json) {
    return CardDto(
      id: json['id'],
      frontContent: json['frontContent'],
      backContent: json['backContent'],
      imageUrl: json['imageUrl'],
      audioUrl: json['audioUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'frontContent': frontContent,
      'backContent': backContent,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

// File: lib/core/domain/dtos/create_card_dto.dart
class CreateCardDto {
  final String frontContent;
  final String backContent;
  final String? imageUrl;
  final String? audioUrl;

  CreateCardDto({
    required this.frontContent,
    required this.backContent,
    this.imageUrl,
    this.audioUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'frontContent': frontContent,
      'backContent': backContent,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
    };
  }
}

// File: lib/core/domain/dtos/update_card_dto.dart
class UpdateCardDto {
  final String id;
  final String frontContent;
  final String backContent;
  final String? imageUrl;
  final String? audioUrl;

  UpdateCardDto({
    required this.id,
    required this.frontContent,
    required this.backContent,
    this.imageUrl,
    this.audioUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'frontContent': frontContent,
      'backContent': backContent,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
    };
  }
}