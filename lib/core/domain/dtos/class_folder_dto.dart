// DTOs
class AssignClassroomFolderRequest {
  final String classRoomId;
  final String folderId;

  AssignClassroomFolderRequest({
    required this.classRoomId,
    required this.folderId,
  });

  Map<String, dynamic> toJson() {
    return {
      'classRoomId': classRoomId,
      'folderId': folderId,
    };
  }
}

class RemoveClassroomFolderRequest {
  final String classRoomId;
  final String folderId;

  RemoveClassroomFolderRequest({
    required this.classRoomId,
    required this.folderId,
  });

  Map<String, dynamic> toJson() {
    return {
      'classRoomId': classRoomId,
      'folderId': folderId,
    };
  }
}
