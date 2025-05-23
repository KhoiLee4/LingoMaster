import 'dart:convert';

import 'package:http/http.dart' as _client;
import 'package:lingo_master/core/data/NativeService/BaseService.dart';
import 'package:lingo_master/core/domain/models/base-reponse.dart';
import 'package:lingo_master/core/domain/models/session.dart';

import '../../domain/dtos/Card/card_dto.dart';
import '../../domain/dtos/Card/create_card_dto.dart';
import '../../domain/dtos/Card/update_card_dto.dart';

class CardService extends BaseService {
  CardService() : super();

  Future<BaseResponse<CardDto>> getCardById(String cardId) async {
    final response = await _client.get(
      Uri.parse('$url_api/api/Card/$cardId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      return BaseResponse<CardDto>.fromJson(
          jsonData, (data) => CardDto.fromJson(data as Map<String, dynamic>));
    } else {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse<CardDto>(
        success: false,
        message: 'Failed to load card, status code: ${response.statusCode}',
        data: null,
        errors: jsonData["message"],
      );
    }
  }

  // Lấy tất cả cards
  Future<BaseResponse<List<CardDto>>> getAllCardsAsync() async {
    final response = await _client.get(
      Uri.parse('$url_api/api/Card/GetAllCards'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse<List<CardDto>>.fromJson(
          jsonData,
          (data) => (data as List<dynamic>)
              .map((item) => CardDto.fromJson(item as Map<String, dynamic>))
              .toList());
    } else {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse<List<CardDto>>(
        success: false,
        message: 'Failed to load card, status code: ${response.statusCode}',
        data: null,
        errors: jsonData["message"],
      );
    }
  }

  //
  // Tạo card mới
  Future<BaseResponse<CardDto>> createCard(CreateCardDto createCardDto) async {
    final response =
        await _client.post(Uri.parse('$url_api/api/Card/CreateCard'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${Session.token}',
            },
            body: jsonEncode(createCardDto.toJson()));
    if (response.statusCode == 201) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse<CardDto>.fromJson(
          jsonData, (data) => CardDto.fromJson(data as Map<String, dynamic>));
    } else {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse<CardDto>(
        success: false,
        message: 'Failed to load card, status code: ${response.statusCode}',
        data: null,
        errors: jsonData["message"],
      );
    }
  }

  //
  // Cập nhật card
  Future<BaseResponse<CardDto>> updateCard(UpdateCardDto updateCardDto) async {
    final response = await _client.put(Uri.parse('$url_api/api/Card/Update'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
        body: jsonEncode(updateCardDto.toJson()));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse<CardDto>.fromJson(
          jsonData, (data) => CardDto.fromJson(data as Map<String, dynamic>));
    } else {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse<CardDto>(
        success: false,
        message: 'Failed to load card, status code: ${response.statusCode}',
        data: null,
        errors: jsonData["message"],
      );
    }
  }

  // Delete Card
  Future<BaseResponse<CardDto>> deleteCard(String cardId) async {
    final response = await _client.delete(
      Uri.parse('$url_api/api/Card/Delete/$cardId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}',
      },
    );



    if (response.statusCode == 204) {
      return BaseResponse<CardDto>(
          success: true, message: 'Delete success', data: null, errors: null);
    } else {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse<CardDto>(
        success: false,
        message: 'Failed to delete card, status code: ${response.statusCode}',
        data: null,
        errors: jsonData['errors'] != null
            ? List<String>.from(jsonData['errors'])
            : null,
      );
    }
  }
  //
  Future<BaseResponse<List<CardDto>>> getCardBySetId(String setId) async {
    final response = await _client.get(
      Uri.parse('$url_api/api/Card/getCardBySetId/$setId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      return BaseResponse<List<CardDto>>.fromJson(
          jsonData,
              (data) => (data as List<dynamic>)
              .map((item) => CardDto.fromJson(item as Map<String, dynamic>))
              .toList());
    } else {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse<List<CardDto>>(
        success: false,
        message: 'Failed to load card, status code: ${response.statusCode}',
        data: null,
        errors: jsonData["message"],
      );
    }
  }
}
