class ImageModel {
  final String id;
  final String url;
  final String altText;
  final String cardId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ImageModel({
    required this.id,
    required this.url,
    required this.altText,
    required this.cardId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['imageId'] ?? json['id'],
      url: json['url'],
      altText: json['altText'],
      cardId: json['cardId'] ?? json['idCard'],
      createdAt: DateTime.parse(json['createdAt'] ?? json['createAt']),
      updatedAt: DateTime.parse(json['updatedAt'] ?? json['updateAt']),
    );
  }
}