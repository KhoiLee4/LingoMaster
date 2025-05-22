class SetUserDto {
  final String idUser;
  final String idSet;
  final bool isOwner;
  final DateTime dateAccess;

  SetUserDto({
    required this.idUser,
    required this.idSet,
    required this.isOwner,
    required this.dateAccess,
  });

  factory SetUserDto.fromJson(Map<String, dynamic> json) {
    return SetUserDto(
      idUser: json['idUser'] ?? '',
      idSet: json['idSet'] ?? '',
      isOwner: json['isOwner'] ?? false,
      dateAccess: json['dateAccess'] != null
          ? DateTime.parse(json['dateAccess'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'idSet': idSet,
      'isOwner': isOwner,
      'dateAccess': dateAccess.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SetUserDto(idUser: $idUser, idSet: $idSet, isOwner: $isOwner, dateAccess: $dateAccess)';
  }
}
