class FolderUserDto {
  final String idUser;
  final String idFolder;
  final bool isOwner;

  FolderUserDto({
    required this.idUser,
    required this.idFolder,
    required this.isOwner,
  });

  factory FolderUserDto.fromJson(Map<String, dynamic> json) {
    return FolderUserDto(
      idUser: json['idUser'] ?? '',
      idFolder: json['idFolder'] ?? '',
      isOwner: json['isOwner'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'idFolder': idFolder,
      'isOwner': isOwner,
    };
  }
}