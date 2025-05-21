import 'package:lingo_master/core/domain/dtos/base_dto.dart';

class RegisterUserDto implements BaseDto
{
    late String email ;
    late String userName;
    late String password;
    late String firstName;
    late String lastName;


    RegisterUserDto({
        required this.email,
        required this.userName,
        required this.password,
        required this.firstName,
        required this.lastName,
    });
    
      @override
      Map<String, dynamic>? toJson() {
        /*
        "email": "user@example.com",
        "userName": "string",
        "password": "stringst",
        "firstName": "string",
        "lastName": "string"
        */
        return {
            'email': email,
            'userName': userName,
            'password': password,
            'firstName': firstName,
            'lastName': lastName,
        };
      }
}