class GetAllFolderByClassroomIdRespone {
  String folderId;
  String folderName;
  int totalSets;
  String? pictureProfile;
  String nameUser;

  GetAllFolderByClassroomIdRespone({
    required this.folderId,
    required this.folderName,
    required this.totalSets,
    this.pictureProfile,
    required this.nameUser,
  });

  factory GetAllFolderByClassroomIdRespone.fromJson(Map<String, dynamic> json) {
    return GetAllFolderByClassroomIdRespone(
      folderId: json['folderId'] ?? '',
      folderName: json['folderName'] ?? '',
      totalSets: json['totalSets'] ?? 0,
      pictureProfile: json['pictureProfile'],
      nameUser: json['nameUser'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'folderId': folderId,
    'folderName': folderName,
    'totalSets': totalSets,
    'pictureProfile': pictureProfile,
    'nameUser': nameUser,
  };
}
