class ClassroomFolderDto {
  String classRoomId;
  String folderId;

  ClassroomFolderDto({
    required this.classRoomId,
    required this.folderId,
  });

  factory ClassroomFolderDto.fromJson(Map<String, dynamic> json) {
    return ClassroomFolderDto(
      classRoomId: json['classRoomId'] ?? '',
      folderId: json['folderId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'classRoomId': classRoomId,
    'folderId': folderId,
  };
}
