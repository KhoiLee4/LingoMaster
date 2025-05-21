// Models for request and response
class AssignFolderUserRequest {
  final String userId;
  final String folderId;
  final bool isOwner;

  AssignFolderUserRequest({
    required this.userId,
    required this.folderId,
    this.isOwner = false,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'folderId': folderId,
    'isOwner': isOwner,
  };
}

class RemoveFolderUserRequest {
  final String userId;
  final String folderId;

  RemoveFolderUserRequest({
    required this.userId,
    required this.folderId,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'folderId': folderId,
  };
}