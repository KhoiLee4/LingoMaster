class RemoveSetUserRequest {
  final String userId;
  final String setId;

  RemoveSetUserRequest({
    required this.userId,
    required this.setId,
  });

  factory RemoveSetUserRequest.fromJson(Map<String, dynamic> json) {
    return RemoveSetUserRequest(
      userId: json['userId'] ?? '',
      setId: json['setId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'setId': setId,
    };
  }

  @override
  String toString() {
    return 'RemoveSetUserRequest(userId: $userId, setId: $setId)';
  }
}
