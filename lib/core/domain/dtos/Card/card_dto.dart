import '../Image/image_dto.dart';

class CardDto {
  String id;          // Guid ở Dart lưu dưới dạng String
  String key;
  String value;
  String idSet;
  ImageDto? image;    // nullable kiểu ImageDto?

  CardDto({
    required this.id,
    required this.key,
    required this.value,
    required this.idSet,
    this.image,
  });

  // Factory tạo object từ JSON map
  factory CardDto.fromJson(Map<String, dynamic> json) {
    return CardDto(
      id: json['id'] ?? '',
      key: json['key'] ?? '',
      value: json['value'] ?? '',
      idSet: json['idSet'] ?? '',
      image: json['image'] != null ? ImageDto.fromJson(json['image'] as Map<String, dynamic>) : null,
    );
  }

  // Hàm convert object về JSON map (nếu cần)
  Map<String, dynamic> toJson() => {
    'id': id,
    'key': key,
    'value': value,
    'idSet': idSet,
    'image': image?.toJson(),
  };
}