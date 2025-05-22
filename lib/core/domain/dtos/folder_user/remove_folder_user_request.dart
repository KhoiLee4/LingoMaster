class RemoveFolderUserRequest {
  final String userId;
  final String folderId;

  RemoveFolderUserRequest({
    required this.userId,
    required this.folderId,
  });

  factory RemoveFolderUserRequest.fromJson(Map<String, dynamic> json) {
    return RemoveFolderUserRequest(
      userId: json['userId'] ?? '',
      folderId: json['folderId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'folderId': folderId,
    };
  }
}