class SetUserDto {
  final String userId;
  final String userName;
  final String? userAvatar;
  final String setId;
  final String setName;
  final String? setDescription;
  final DateTime dateAccess;
  final bool isOwner;

  SetUserDto({
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.setId,
    required this.setName,
    this.setDescription,
    required this.dateAccess,
    required this.isOwner,
  });

  factory SetUserDto.fromJson(Map<String, dynamic> json) {
    return SetUserDto(
      userId: json['userId'],
      userName: json['userName'],
      userAvatar: json['userAvatar'],
      setId: json['setId'],
      setName: json['setName'],
      setDescription: json['setDescription'],
      dateAccess: DateTime.parse(json['dateAccess']),
      isOwner: json['isOwner'],
    );
  }
}

class AssignSetUserRequest {
  final String userId;
  final String setId;
  final bool isOwner;

  AssignSetUserRequest({
    required this.userId,
    required this.setId,
    this.isOwner = false,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'setId': setId,
    'isOwner': isOwner,
  };
}

class UpdateAccessDateRequest {
  final String userId;
  final String setId;
  final DateTime dateAccess;

  UpdateAccessDateRequest({
    required this.userId,
    required this.setId,
    required this.dateAccess,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'setId': setId,
    'dateAccess': dateAccess.toIso8601String(),
  };
}

class RemoveSetUserRequest {
  final String userId;
  final String setId;

  RemoveSetUserRequest({
    required this.userId,
    required this.setId,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'setId': setId,
  };
}