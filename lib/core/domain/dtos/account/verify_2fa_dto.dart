class Verify2FADto {
  final String? userId;
  final String verifyCode;

  Verify2FADto({
    this.userId,
    required this.verifyCode,
  });

  factory Verify2FADto.fromJson(Map<String, dynamic> json) {
    return Verify2FADto(
      userId: json['userId'],
      verifyCode: json['verifyCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'verifyCode': verifyCode,
  };
}