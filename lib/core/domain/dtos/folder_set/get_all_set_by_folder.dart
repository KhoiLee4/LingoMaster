class GetAllSetsByFolderIdResponse {
  final String setId;      // Guid as String in Dart
  final String setName;
  final int totalCards;
  final String nameOwner;

  GetAllSetsByFolderIdResponse({
    required this.setId,
    required this.setName,
    required this.totalCards,
    required this.nameOwner,
  });

  factory GetAllSetsByFolderIdResponse.fromJson(Map<String, dynamic> json) {
    return GetAllSetsByFolderIdResponse(
      setId: json['setId'] ?? '',
      setName: json['setName'] ?? '',
      totalCards: json['toTalCards'] ?? 0,  // Notice the capital 'T' matching the C# property
      nameOwner: json['nameOwner'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'setId': setId,
    'setName': setName,
    'toTalCards': totalCards,  // Matching the casing from the C# model
    'nameOwner': nameOwner,
  };
}