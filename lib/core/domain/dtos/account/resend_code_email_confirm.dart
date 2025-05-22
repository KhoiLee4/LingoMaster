class ResendCodeEmailConfirmDto {
  final String email;

  ResendCodeEmailConfirmDto({
    required this.email,
  });

  factory ResendCodeEmailConfirmDto.fromJson(Map<String, dynamic> json) {
    return ResendCodeEmailConfirmDto(
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
  };
}