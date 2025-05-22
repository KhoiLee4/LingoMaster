import 'dart:convert';

import 'package:http/http.dart' as _client;

import '../../domain/dtos/card_user/assignCardRequest.dart';
import '../../domain/dtos/card_user/card_user_dto.dart';
import '../../domain/dtos/card_user/update_card_status_request.dart';
import '../../domain/models/base-reponse.dart';
import '../../domain/models/session.dart';
import 'BaseService.dart';


class CardUserService extends BaseService {
  CardUserService({bool ignoreSSLCertificate = false})
      : super(ignoreSSLCertificate: ignoreSSLCertificate);

  // Gán card cho người dùng
  Future<BaseResponse<String>> assignCardToUser(AssignCardRequest request) async {
    final url = '$url_api/api/CardUser/assignCardToUser';

    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu API cần
      },
      body: jsonEncode(request.toJson()),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<String>.fromJson(
        jsonData,
            (data) => data as String,
      );
    } else {
      return BaseResponse<String>(
        success: false,
        message: jsonData['message'] ?? 'Failed to assign card',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  Future<BaseResponse<String>> updateCardUserStatus(UpdateCardStatusRequest request) async {
    final url = '$url_api/api/CardUser/updateStatus';

    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu API cần
      },
      body: jsonEncode(request.toJson()),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<String>.fromJson(
        jsonData,
            (data) => data as String,
      );
    } else {
      return BaseResponse<String>(
        success: false,
        message: jsonData['message'] ?? 'Failed to update card user status',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }



  Future<BaseResponse<List<CardUserDto>>> getCardsForUser(String userId) async {
    final url = '$url_api/api/CardUser/user/$userId';

    final response = await _client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần
      },
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<List<CardUserDto>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => CardUserDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<CardUserDto>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load cards for user',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }


  Future<BaseResponse<CardUserDto>> getCardStatus(String userId, String cardId) async {
    final url = Uri.parse('$url_api/api/carduser/status').replace(
      queryParameters: {
        'userId': userId,
        'cardId': cardId,
      },
    );

    final response = await _client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu API cần
      },
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<CardUserDto>.fromJson(
        jsonData,
            (data) => CardUserDto.fromJson(data as Map<String, dynamic>),
      );
    } else {
      return BaseResponse<CardUserDto>(
        success: false,
        message: jsonData['message'] ?? 'Failed to get card status',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

}