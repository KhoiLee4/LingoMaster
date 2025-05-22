class RemoveClassRoomUserDto {
  String userId;
  String classRoomId;

  RemoveClassRoomUserDto({
    required this.userId,
    required this.classRoomId,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'classRoomId': classRoomId,
  };
}
