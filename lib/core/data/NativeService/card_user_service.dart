// import 'dart:convert';
//
// import 'package:http/http.dart' as _client;
// import 'package:lingo_master/core/data/NativeService/BaseService.dart';
// import 'package:lingo_master/core/domain/models/base-reponse.dart';
// import 'package:lingo_master/core/domain/models/session.dart';
//
// import '../../domain/dtos/user_card_dto.dart';
//
//
// class CardUserService extends BaseService {
//   CardUserService({bool ignoreSSLCertificate = false})
//       : super(ignoreSSLCertificate: ignoreSSLCertificate);
//
//   // Gán card cho người dùng
//   Future<BaseResponse> assignCardToUser(String userId, String cardId) async {
//     try {
//       final response = await _client.post(
//         Uri.parse('$url_api/api/CardUser/assignCardToUser'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${Session.token}',
//         },
//         body: jsonEncode({
//           'userId': userId,
//           'cardId': cardId,
//         }),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//     } catch (e) {
//       print('AssignCardToUser exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Cập nhật trạng thái học của card
//   Future<BaseResponse> updateCardStatus(String userId, String cardId, CardLearningStatus status) async {
//     try {
//       final response = await _client.put(
//         Uri.parse('$url_api/api/CardUser/updateStatus'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${Session.token}',
//         },
//         body: jsonEncode({
//           'userId': userId,
//           'cardId': cardId,
//           'status': status.index,
//         }),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//     } catch (e) {
//       print('UpdateCardStatus exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Lấy danh sách card của người dùng
//   Future<BaseResponse> getCardsForUser(String userId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/CardUser/user/$userId'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${Session.token}',
//         },
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//     } catch (e) {
//       print('GetCardsForUser exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Lấy trạng thái học của card
//   Future<BaseResponse> getCardStatus(String userId, String cardId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/CardUser/status?userId=$userId&cardId=$cardId'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${Session.token}',
//         },
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//     } catch (e) {
//       print('GetCardStatus exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
// }