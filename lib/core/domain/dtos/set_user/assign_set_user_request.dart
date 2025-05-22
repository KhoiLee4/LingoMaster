class AssignSetUserRequest {
  final String userId;
  final String setId;
  final bool isOwner;

  AssignSetUserRequest({
    required this.userId,
    required this.setId,
    this.isOwner = false,
  });

  factory AssignSetUserRequest.fromJson(Map<String, dynamic> json) {
    return AssignSetUserRequest(
      userId: json['userId'] ?? '',
      setId: json['setId'] ?? '',
      isOwner: json['isOwner'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'setId': setId,
      'isOwner': isOwner,
    };
  }

  @override
  String toString() {
    return 'AssignSetUserRequest(userId: $userId, setId: $setId, isOwner: $isOwner)';
  }
}