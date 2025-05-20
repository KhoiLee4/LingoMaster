class Permissions{
  String id;
  String Name;
  String Description;
  bool IsCorePermission;
  DateTime CreatedAt;
  DateTime UpdatedAt;
  Permissions({
    required this.id,
    required this.Name,
    required this.Description,
    required this.IsCorePermission,
    required this.CreatedAt,
    required this.UpdatedAt
  });
}