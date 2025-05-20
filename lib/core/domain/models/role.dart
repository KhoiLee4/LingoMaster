class Role{
  String Id;
  DateTime CreatedAt;
  DateTime UpdatedAt;
  String? Name;
  String? NormalizedName;
  String? ConcurrencyStamp; 

  Role({
    required this.Id,
    required this.CreatedAt,
    required this.UpdatedAt,
    this.Name,
    this.NormalizedName,
    this.ConcurrencyStamp
  });
  
}