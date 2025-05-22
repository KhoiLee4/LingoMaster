class FolderSetDto {
  final String folderId;  // Guid as String in Dart
  final String setId;     // Guid as String in Dart

  FolderSetDto({
    required this.folderId,
    required this.setId,
  });

  factory FolderSetDto.fromJson(Map<String, dynamic> json) {
    return FolderSetDto(
      folderId: json['folderId'] ?? '',
      setId: json['setId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'folderId': folderId,
    'setId': setId,
  };
}