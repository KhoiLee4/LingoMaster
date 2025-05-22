class LoginUserDto {
  final String emailOrUsername;
  final String password;

  LoginUserDto({
    required this.emailOrUsername,
    required this.password,
  });

  factory LoginUserDto.fromJson(Map<String, dynamic> json) {
    return LoginUserDto(
      emailOrUsername: json['emailOrUsername'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'emailOrUsername': emailOrUsername,
    'password': password,
  };
}