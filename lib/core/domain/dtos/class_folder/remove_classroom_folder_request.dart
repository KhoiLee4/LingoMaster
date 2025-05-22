class RemoveClassroomFolderRequest {
  String classRoomId;
  String folderId;

  RemoveClassroomFolderRequest({
    required this.classRoomId,
    required this.folderId,
  });

  Map<String, dynamic> toJson() => {
    'classRoomId': classRoomId,
    'folderId': folderId,
  };
}
