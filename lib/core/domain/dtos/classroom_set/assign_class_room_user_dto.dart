class AssignClassRoomUserDto {
  String userId;
  String classRoomId;
  bool isOwner;

  AssignClassRoomUserDto({
    required this.userId,
    required this.classRoomId,
    this.isOwner = false,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'classRoomId': classRoomId,
    'isOwner': isOwner,
  };
}
