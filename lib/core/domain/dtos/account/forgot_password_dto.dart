class ForgotPasswordDto {
  final String email;

  ForgotPasswordDto({
    required this.email,
  });

  factory ForgotPasswordDto.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordDto(
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
  };
}