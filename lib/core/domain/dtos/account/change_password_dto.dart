class ChangePasswordDto {
  final String currentPassword;
  final String newPassword;

  ChangePasswordDto({
    required this.currentPassword,
    required this.newPassword,
  });

  factory ChangePasswordDto.fromJson(Map<String, dynamic> json) {
    return ChangePasswordDto(
      currentPassword: json['currentPassword'] ?? '',
      newPassword: json['newPassword'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'currentPassword': currentPassword,
    'newPassword': newPassword,
  };
}