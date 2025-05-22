class CreatedSetDto {
  final String id;
  final String name;
  final int totalCard;
  final String nameOwner;
  final String? urlAvatar;
  final DateTime createdAt;
  final DateTime dateAccess;

  CreatedSetDto({
    required this.id,
    required this.name,
    required this.totalCard,
    required this.nameOwner,
    this.urlAvatar,
    required this.createdAt,
    required this.dateAccess,
  });

  factory CreatedSetDto.fromJson(Map<String, dynamic> json) {
    return CreatedSetDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      totalCard: json['totalCard'] ?? 0,
      nameOwner: json['nameOnwer'] ?? json['nameOwner'] ?? '', // Handle typo in API
      urlAvatar: json['urlAvatar'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      dateAccess: json['dateAccsess'] != null // Handle typo in API
          ? DateTime.parse(json['dateAccsess'])
          : (json['dateAccess'] != null ? DateTime.parse(json['dateAccess']) : DateTime.now()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'totalCard': totalCard,
      'nameOwner': nameOwner,
      'urlAvatar': urlAvatar,
      'createdAt': createdAt.toIso8601String(),
      'dateAccess': dateAccess.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'CreatedSetDto(id: $id, name: $name, totalCard: $totalCard, nameOwner: $nameOwner, urlAvatar: $urlAvatar, createdAt: $createdAt, dateAccess: $dateAccess)';
  }
}