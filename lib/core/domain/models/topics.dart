class Topics{
  String Id;
  String Name;
  String ParentTopicId;
  DateTime CreatedAt;
  String Description;
  bool IsActive;
  DateTime UpdatedAt;

  Topics({
    required this.Id,
    required this.Name,
    required this.ParentTopicId,
    required this.CreatedAt,
    required this.Description,
    required this.IsActive,
    required this.UpdatedAt
  });
}