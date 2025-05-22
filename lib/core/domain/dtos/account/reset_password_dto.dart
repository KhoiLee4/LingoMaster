class ResetPasswordDto {
  final String token;
  final String email;
  final String newPassword;

  ResetPasswordDto({
    required this.token,
    required this.email,
    required this.newPassword,
  });

  factory ResetPasswordDto.fromJson(Map<String, dynamic> json) {
    return ResetPasswordDto(
      token: json['token'] ?? '',
      email: json['email'] ?? '',
      newPassword: json['newPassword'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'email': email,
    'newPassword': newPassword,
  };
}