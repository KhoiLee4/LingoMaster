class AssignCardRequest {
  String userId;  // Guid chuyển thành String
  String cardId;

  AssignCardRequest({
    required this.userId,
    required this.cardId,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'cardId': cardId,
  };
}
