class GetAllSetByClassroomIdRespone {
  String idSet;
  String nameSet;
  int totalCard;
  String pictureProfile;
  String nameUser;
  DateTime createdSet;

  GetAllSetByClassroomIdRespone({
    required this.idSet,
    required this.nameSet,
    required this.totalCard,
    required this.pictureProfile,
    required this.nameUser,
    required this.createdSet,
  });

  factory GetAllSetByClassroomIdRespone.fromJson(Map<String, dynamic> json) {
    return GetAllSetByClassroomIdRespone(
      idSet: json['idSet'] ?? '',
      nameSet: json['nameSet'] ?? '',
      totalCard: json['totalCard'] ?? 0,
      pictureProfile: json['pictureProfile'] ?? '',
      nameUser: json['nameUser'] ?? '',
      createdSet: DateTime.parse(json['createdSet']),
    );
  }

  Map<String, dynamic> toJson() => {
    'idSet': idSet,
    'nameSet': nameSet,
    'totalCard': totalCard,
    'pictureProfile': pictureProfile,
    'nameUser': nameUser,
    'createdSet': createdSet.toIso8601String(),
  };
}
