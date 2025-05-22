class ConfirmEmailWithCodeDto {
  final String code;
  final String email;

  ConfirmEmailWithCodeDto({
    required this.code,
    required this.email,
  });

  factory ConfirmEmailWithCodeDto.fromJson(Map<String, dynamic> json) {
    return ConfirmEmailWithCodeDto(
      code: json['code'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'email': email,
  };
}