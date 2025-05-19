class SetUsers{
  String IdUser;
  String IdSet;
  bool IsOwner;
  DateTime DateAccess;

  SetUsers({
    required this.IdUser,
    required this.IdSet,
    required this.IsOwner,
    required this.DateAccess
  });
}