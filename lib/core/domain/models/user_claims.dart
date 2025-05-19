class UserClaims{
  int id;
  String UserId;
  String? ClaimType;
  String? ClaimValue;
  UserClaims({
    required this.id,
    required this.UserId,
    this.ClaimType,
    this.ClaimValue
  });
}