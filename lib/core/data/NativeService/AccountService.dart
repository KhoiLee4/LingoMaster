import 'dart:convert';

import 'package:http/http.dart' as _client;
import 'package:lingo_master/core/data/NativeService/BaseService.dart';
import 'package:lingo_master/core/domain/models/session.dart';

import '../../domain/dtos/account/register_user_dto.dart';
import '../../domain/models/basereponse.dart';
import '../../domain/models/user.dart';

class AccountService extends BaseService {
  AccountService() : super();
  //--------- Đăng nhập ---------
 Future<BaseResponse> login(String email, String password) async {
  try {
    print('URL API: $url_api');
    
    final response = await _client.post(
      Uri.parse(url_api + '/api/Account/Login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'emailOrUsername': email,
        'password': password,
      }),
    );
    
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    
    // Check if login successful
    if (jsonData['success'] == true && jsonData['data'] != null) {
      final data = jsonData['data'];
      
      // Set token
      Session.token = data['token'];
      
      // Set user - create User object from API response
      final userJson = data['user'];
      Session.user = User(
        Id : userJson['id'],
        FirstName: userJson['firstName'] ?? '',
        LastName: userJson['lastName'] ?? '',
        Email: userJson['email'] ?? '',
        DateOfBirth: userJson['dateOfBirth'] != null ? DateTime.parse(userJson['dateOfBirth']) : DateTime.now(),
        IsDeleted: userJson['isDeleted'] ?? false,
        IsConfirmedEmail: userJson['emailConfirmed'] ?? false,
        Status: userJson['status'] ?? 'true',
        CreatedAt: userJson['createdAt'] != null ? DateTime.parse(userJson['createdAt']) : DateTime.now(),
        UpdatedAt: userJson['updatedAt'] != null ? DateTime.parse(userJson['updatedAt']) : DateTime.now(),
        username: userJson['userName'],
        NormalizedUserName: userJson['normalizedUserName'],
        NormalizedEmail: userJson['normalizedEmail'],
        EmailConfirmed: userJson['emailConfirmed'] ?? false,
        PasswordHash: userJson['passwordHash'],
        SecurityStamp: userJson['securityStamp'],
        ConcurrencyStamp: userJson['concurrencyStamp'],
        PhoneNumber: userJson['phoneNumber'],
        PhoneNumberConfirmed: userJson['phoneNumberConfirmed'] ?? false,
        TwoFactorEnabled: userJson['twoFactorEnabled'] ?? false,
        LockoutEnd: userJson['lockoutEnd'] != null ? DateTime.parse(userJson['lockoutEnd']) : DateTime.now(),
        AccessFailedCount: userJson['accessFailedCount'] ?? 0,
        ProfilePicture: userJson['profilePicture'],
      );
      
      print('✅ Login successful - User ID: ${Session.user?.Id}');
    }
    
    return BaseResponse.fromJson(jsonData);
    
  } catch (e) {
    print('Login exception: $e');
    return BaseResponse(
      Success: false,
      Message: 'Connection error: ${e.toString()}',
    );
  }
}
  //--------- ConfirmEmailWithCode ---------
  Future<BaseResponse> verify(String code) async {
    try {
      final response = await _client.post(
        Uri.parse(url_api + '/api/Account/ConfirmEmailWithCode'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'code': code,
          'email': '${Session.email}',
        }),
      );
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      return BaseResponse(
        Success: false,
        Message:"ERROR API"+ e.toString(),
      );
    }
  }
// Example of how you would use the token for subsequent calls

  //--------- Tạo tài khoản ---------
  Future<BaseResponse> createAccount
    (
      RegisterUserDto reg
    ) async {
        try {
        final response = await _client.post(
          Uri.parse(url_api + '/api/Account/RegisterWithCode'),
          headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
          body: jsonEncode(reg.toJson())
        );
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return BaseResponse.fromJson(jsonData);

      } catch (e) {
        return BaseResponse(
          Success: false,
          Message: e.toString()
        );
      }
    }
}