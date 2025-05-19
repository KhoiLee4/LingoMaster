class Folder{
  String Id;
  String Name;
  bool IsDeleted;
  DateTime CreatedAt;
  DateTime UpdatedAt;



  Folder({
    required this.Id,
    required this.Name,
    required this.IsDeleted,
    required this.CreatedAt,
    required this.UpdatedAt
  });
}