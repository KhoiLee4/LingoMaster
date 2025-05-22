class CardUserDto {
  String cardId;
  String key;
  String value;
  bool isFavorite;
  bool isKnow;
  bool isChecked;
  bool isLearned;

  CardUserDto({
    required this.cardId,
    required this.key,
    required this.value,
    this.isFavorite = false,
    required this.isKnow,
    required this.isChecked,
    required this.isLearned,
  });

  factory CardUserDto.fromJson(Map<String, dynamic> json) {
    return CardUserDto(
      cardId: json['cardId'] ?? '',
      key: json['key'] ?? '',
      value: json['value'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      isKnow: json['isKnow'] ?? false,
      isChecked: json['isChecked'] ?? false,
      isLearned: json['isLearned'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'cardId': cardId,
    'key': key,
    'value': value,
    'isFavorite': isFavorite,
    'isKnow': isKnow,
    'isChecked': isChecked,
    'isLearned': isLearned,
  };
}
