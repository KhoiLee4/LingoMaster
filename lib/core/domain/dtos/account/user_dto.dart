class User {
  final String id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final DateTime? dateOfBirth;
  final bool isDeleted;
  final bool isConfirmedEmail;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool twoFactorEnabled;
  final bool emailConfirmed;
  final String phoneNumber;
  final bool phoneNumberConfirmed;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profilePicture,
    this.dateOfBirth,
    this.isDeleted = false,
    this.isConfirmedEmail = false,
    this.status = 'True',
    required this.createdAt,
    required this.updatedAt,
    this.twoFactorEnabled = false,
    this.emailConfirmed = false,
    this.phoneNumber = '',
    this.phoneNumberConfirmed = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profilePicture: json['profilePicture'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      isDeleted: json['isDeleted'] ?? false,
      isConfirmedEmail: json['isConfirmedEmail'] ?? false,
      status: json['status'] ?? 'True',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
      twoFactorEnabled: json['twoFactorEnabled'] ?? false,
      emailConfirmed: json['emailConfirmed'] ?? false,
      phoneNumber: json['phoneNumber'] ?? '',
      phoneNumberConfirmed: json['phoneNumberConfirmed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userName': userName,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'profilePicture': profilePicture,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'isDeleted': isDeleted,
    'isConfirmedEmail': isConfirmedEmail,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'twoFactorEnabled': twoFactorEnabled,
    'emailConfirmed': emailConfirmed,
    'phoneNumber': phoneNumber,
    'phoneNumberConfirmed': phoneNumberConfirmed,
  };
}