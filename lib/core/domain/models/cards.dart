class Cards{
  String Id;
  String Key;
  String Value;
  bool IsFavorite;
  String IdSet;
  String? IdImage;

  Cards({
    required this.Id,
    required this.Key,
    required this.Value,
    required this.IsFavorite,
    required this.IdSet,
     this.IdImage
  });
}