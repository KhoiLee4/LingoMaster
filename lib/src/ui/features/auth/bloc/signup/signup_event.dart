abstract class SignupEvent {}

class SignupSubmitted extends SignupEvent {
  final DateTime? birthday;
  final String email;
  final String password;

  SignupSubmitted(
      {required this.birthday, required this.email, required this.password});
}
