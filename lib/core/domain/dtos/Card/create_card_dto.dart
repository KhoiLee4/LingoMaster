
import '../Image/image_dto.dart';

class CreateCardDto {
  final String key;
  final String value;
  final String idSet;    // Guid thay bằng String
  final ImageDto? image;

  CreateCardDto({
    required this.key,
    required this.value,
    required this.idSet,
    this.image,
  });

  factory CreateCardDto.fromJson(Map<String, dynamic> json) {
    return CreateCardDto(
      key: json['key'] ?? '',
      value: json['value'] ?? '',
      idSet: json['idSet'] ?? '',
      image: json['image'] != null ? ImageDto.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
      'idSet': idSet,
      'image': image?.toJson(),
    };
  }
}
