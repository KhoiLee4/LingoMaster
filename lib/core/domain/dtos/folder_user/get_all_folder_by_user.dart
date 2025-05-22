class GetAllFolderByUserIdResponse {
  final String folderId;
  final String folderName;
  final String? pictureProfile;
  final String nameUser;

  GetAllFolderByUserIdResponse({
    required this.folderId,
    required this.folderName,
    this.pictureProfile,
    required this.nameUser,
  });

  factory GetAllFolderByUserIdResponse.fromJson(Map<String, dynamic> json) {
    return GetAllFolderByUserIdResponse(
      folderId: json['folderId'] ?? '',
      folderName: json['folderName'] ?? '',
      pictureProfile: json['pictureProfile'],
      nameUser: json['nameUser'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'folderId': folderId,
      'folderName': folderName,
      'pictureProfile': pictureProfile,
      'nameUser': nameUser,
    };
  }
}