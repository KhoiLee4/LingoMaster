class User{
  String? Id;
  String FirstName;
  String LastName;
  String Email;
  DateTime DateOfBirth;
  bool IsDeleted;
  bool IsConfirmedEmail;
  String Status;
  DateTime CreatedAt;
  DateTime UpdatedAt;
  String? username;
  String? NormalizedUserName;
  String? NormalizedEmail;
  bool EmailConfirmed;
  String? PasswordHash;
  String? SecurityStamp;
  String? ConcurrencyStamp;
  String? PhoneNumber;
  bool PhoneNumberConfirmed;
  bool TwoFactorEnabled;
  DateTime LockoutEnd;
  int AccessFailedCount;
  String? ProfilePicture;

  User({
    required this.Id,
    required this.FirstName,
    required this.LastName,
    required this.Email,
    required this.DateOfBirth,
    required this.IsDeleted,
    required this.IsConfirmedEmail,
    required this.Status,
    required this.CreatedAt,
    required this.UpdatedAt,
    this.username,
    this.NormalizedUserName,
    this.NormalizedEmail,
    required this.EmailConfirmed,
    this.PasswordHash,
    this.SecurityStamp,
    this.ConcurrencyStamp,
    this.PhoneNumber,
    required this.PhoneNumberConfirmed,
    required this.TwoFactorEnabled,
    required this.LockoutEnd,
    required this.AccessFailedCount,
    this.ProfilePicture
  });
}