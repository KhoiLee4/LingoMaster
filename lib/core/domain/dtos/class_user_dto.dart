// DTOs
class AssignClassRoomUserDto {
  final String userId;
  final String classRoomId;
  final bool isOwner;

  AssignClassRoomUserDto({
    required this.userId,
    required this.classRoomId,
    required this.isOwner,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'classRoomId': classRoomId,
      'isOwner': isOwner,
    };
  }
}

class RemoveClassRoomUserDto {
  final String userId;
  final String classRoomId;

  RemoveClassRoomUserDto({
    required this.userId,
    required this.classRoomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'classRoomId': classRoomId,
    };
  }
}
