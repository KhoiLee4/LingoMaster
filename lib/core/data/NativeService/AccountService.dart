import 'dart:convert';

import 'package:http/http.dart' as _client;
import 'package:lingo_master/core/data/NativeService/BaseService.dart';
import 'package:lingo_master/core/domain/dtos/register_user_dto.dart';
import 'package:lingo_master/core/domain/models/base-reponse.dart';
import 'package:lingo_master/core/domain/models/session.dart';

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
          'Accept': 'application/json',},
        body: jsonEncode({
          'emailOrUsername': email,
          'password': password,
        }),
      );
      
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          Session.token = jsonData['token'];
          Session.user = jsonData['user'];
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