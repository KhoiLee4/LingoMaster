class UpdateAccessDateRequest {
  final String userId;
  final String setId;
  final DateTime dateAccess;

  UpdateAccessDateRequest({
    required this.userId,
    required this.setId,
    DateTime? dateAccess,
  }) : dateAccess = dateAccess ?? DateTime.now();

  factory UpdateAccessDateRequest.fromJson(Map<String, dynamic> json) {
    return UpdateAccessDateRequest(
      userId: json['userId'] ?? '',
      setId: json['setId'] ?? '',
      dateAccess: json['dateAccess'] != null
          ? DateTime.parse(json['dateAccess'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'setId': setId,
      'dateAccess': dateAccess.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'UpdateAccessDateRequest(userId: $userId, setId: $setId, dateAccess: $dateAccess)';
  }
}