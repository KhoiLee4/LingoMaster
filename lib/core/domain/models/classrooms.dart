class Classrooms {
  String Id;
  String Name;
  String ClassCode;
  bool IsPublic;
  DateTime CreatedAt;
  DateTime UpdatedAt;

  Classrooms({
    required this.Id,
    required this.Name,
    required this.ClassCode,
    required this.IsPublic,
    required this.CreatedAt,
    required this.UpdatedAt
  });
}