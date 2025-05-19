import 'package:lingo_master/core/domain/models/user.dart';

class UserLogin{
  String LoginProvider;
  String ProviderKey;
  String? ProviderDisplayName;
  String UserId;
  UserLogin({
    required this.LoginProvider,
    required this.ProviderKey,
    this.ProviderDisplayName,
    required this.UserId
  });
}