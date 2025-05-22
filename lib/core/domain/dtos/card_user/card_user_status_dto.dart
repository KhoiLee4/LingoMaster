class CardUserStatusDto {
  bool isFavorite;
  bool isKnow;
  bool isChecked;
  bool isLearned;

  CardUserStatusDto({
    this.isFavorite = false,
    required this.isKnow,
    required this.isChecked,
    required this.isLearned,
  });

  factory CardUserStatusDto.fromJson(Map<String, dynamic> json) {
    return CardUserStatusDto(
      isFavorite: json['isFavorite'] ?? false,
      isKnow: json['isKnow'] ?? false,
      isChecked: json['isChecked'] ?? false,
      isLearned: json['isLearned'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'isFavorite': isFavorite,
    'isKnow': isKnow,
    'isChecked': isChecked,
    'isLearned': isLearned,
  };
}