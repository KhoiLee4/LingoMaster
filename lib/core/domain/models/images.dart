class Images{
  String Id;
  String Url;
  String? AltText;
  DateTime CreatedAt;
  DateTime UpdatedAt;
  String IdCard;

  Images({
    required this.Id,
    required this.Url,
    this.AltText,
    required this.CreatedAt,
    required this.UpdatedAt,
    required this.IdCard
  });
}