class GetAllClassByUserIdRespone {
  String classId;
  String className;
  String? description;
  String classCode;
  int totalSets;
  int totalUsersJoin;

  GetAllClassByUserIdRespone({
    required this.classId,
    required this.className,
    this.description,
    required this.classCode,
    required this.totalSets,
    required this.totalUsersJoin,
  });

  factory GetAllClassByUserIdRespone.fromJson(Map<String, dynamic> json) {
    return GetAllClassByUserIdRespone(
      classId: json['classId'] ?? '',
      className: json['className'] ?? '',
      description: json['description'],
      classCode: json['classCode'] ?? '',
      totalSets: json['totalSets'] ?? 0,
      totalUsersJoin: json['totalUsersJoin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'classId': classId,
    'className': className,
    'description': description,
    'classCode': classCode,
    'totalSets': totalSets,
    'totalUsersJoin': totalUsersJoin,
  };
}
