class AssignClassroomFolderRequest {
  String classRoomId;
  String folderId;

  AssignClassroomFolderRequest({
    required this.classRoomId,
    required this.folderId,
  });

  Map<String, dynamic> toJson() => {
    'classRoomId': classRoomId,
    'folderId': folderId,
  };
}
