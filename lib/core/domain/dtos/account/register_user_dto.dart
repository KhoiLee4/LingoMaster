class RegisterUserDto {
  final String email;
  final String userName;
  final String password;
  final String firstName;
  final String lastName;

  RegisterUserDto({
    required this.email,
    required this.userName,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory RegisterUserDto.fromJson(Map<String, dynamic> json) {
    return RegisterUserDto(
      email: json['email'] ?? '',
      userName: json['userName'] ?? '',
      password: json['password'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'userName': userName,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
  };
}