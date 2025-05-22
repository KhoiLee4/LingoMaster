class AssignFolderUserRequest {
  final String userId;
  final String folderId;
  final bool isOwner;

  AssignFolderUserRequest({
    required this.userId,
    required this.folderId,
    this.isOwner = false,
  });

  factory AssignFolderUserRequest.fromJson(Map<String, dynamic> json) {
    return AssignFolderUserRequest(
      userId: json['userId'] ?? '',
      folderId: json['folderId'] ?? '',
      isOwner: json['isOwner'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'folderId': folderId,
      'isOwner': isOwner,
    };
  }
}