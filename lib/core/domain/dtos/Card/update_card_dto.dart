import '../Image/image_dto.dart';


class UpdateCardDto {
  String id;        // Guid trong Dart lưu dưới dạng String
  String key;
  String value;
  String idSet;
  ImageDto? image;

  UpdateCardDto({
    required this.id,
    required this.key,
    required this.value,
    required this.idSet,
    this.image,
  });

  factory UpdateCardDto.fromJson(Map<String, dynamic> json) {
    return UpdateCardDto(
      id: json['id'] ?? '',
      key: json['key'] ?? '',
      value: json['value'] ?? '',
      idSet: json['idSet'] ?? '',
      image: json['image'] != null ? ImageDto.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'value': value,
      'idSet': idSet,
      'image': image?.toJson(),
    };
  }
}
