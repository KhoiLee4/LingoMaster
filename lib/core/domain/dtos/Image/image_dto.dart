class ImageDto {
  // Các trường trong ImageDto, ví dụ:
  String? url;
  String?  altText;
  ImageDto({ this.url , this.altText });

  factory ImageDto.fromJson(Map<String, dynamic> json) {
    return ImageDto(url: json['url'] ?? '', altText: json['altText'] ?? '');
  }

  Map<String, dynamic> toJson() => {
    'url': url,
    'altText' : altText,
  };
}