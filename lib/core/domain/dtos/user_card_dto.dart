// File: lib/core/domain/dtos/user_card_dto.dart
import 'package:lingo_master/core/domain/dtos/card_dto.dart';

class UserCardDto {
  final String userId;
  final String cardId;
  final CardLearningStatus status;
  final DateTime assignedDate;
  final DateTime? lastReviewDate;
  final CardDto? card;

  UserCardDto({
    required this.userId,
    required this.cardId,
    required this.status,
    required this.assignedDate,
    this.lastReviewDate,
    this.card,
  });

  factory UserCardDto.fromJson(Map<String, dynamic> json) {
    return UserCardDto(
      userId: json['userId'],
      cardId: json['cardId'],
      status: CardLearningStatus.values[json['status']],
      assignedDate: DateTime.parse(json['assignedDate']),
      lastReviewDate: json['lastReviewDate'] != null ? DateTime.parse(json['lastReviewDate']) : null,
      card: json['card'] != null ? CardDto.fromJson(json['card']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'cardId': cardId,
      'status': status.index,
      'assignedDate': assignedDate.toIso8601String(),
      'lastReviewDate': lastReviewDate?.toIso8601String(),
      'card': card?.toJson(),
    };
  }
}

class AssignCardRequest {
  final String userId;
  final String cardId;

  AssignCardRequest({
    required this.userId,
    required this.cardId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'cardId': cardId,
    };
  }
}

class UpdateCardStatusRequest {
  final String userId;
  final String cardId;
  final CardLearningStatus status;

  UpdateCardStatusRequest({
    required this.userId,
    required this.cardId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'cardId': cardId,
      'status': status.index,
    };
  }
}

// File: lib/core/domain/enums/card_learning_status.dart
enum CardLearningStatus {
  notStarted,
  started,
  learning,
  familiar,
  mastered
}