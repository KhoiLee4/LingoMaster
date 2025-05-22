import 'card_user_status_dto.dart';

class UpdateCardStatusRequest {
  String userId; // Guid chuyển thành String
  String cardId;
  CardUserStatusDto status;

  UpdateCardStatusRequest({
    required this.userId,
    required this.cardId,
    required this.status,
  });

  factory UpdateCardStatusRequest.fromJson(Map<String, dynamic> json) {
    return UpdateCardStatusRequest(
      userId: json['userId'] ?? '',
      cardId: json['cardId'] ?? '',
      status: CardUserStatusDto.fromJson(json['status'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'cardId': cardId,
    'status': status.toJson(),
  };
}