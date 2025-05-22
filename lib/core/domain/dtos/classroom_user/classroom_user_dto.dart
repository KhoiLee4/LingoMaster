class ClassRoomUserDto {
  String userId;
  String classRoomId;
  bool isOwner;

  ClassRoomUserDto({
    required this.userId,
    required this.classRoomId,
    required this.isOwner,
  });

  factory ClassRoomUserDto.fromJson(Map<String, dynamic> json) {
    return ClassRoomUserDto(
      userId: json['userId'] ?? '',
      classRoomId: json['classRoomId'] ?? '',
      isOwner: json['isOwner'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'classRoomId': classRoomId,
    'isOwner': isOwner,
  };
}
