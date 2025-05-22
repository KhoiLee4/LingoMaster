// import 'dart:convert';
//
// import 'package:http/http.dart' as _client;
// import 'package:lingo_master/core/data/NativeService/BaseService.dart';
// import 'package:lingo_master/core/domain/models/base-reponse.dart';
// import 'package:lingo_master/core/domain/models/session.dart';
// import 'package:lingo_master/core/domain/dtos/card_dto.dart';
//
// class CardService extends BaseService {
//   CardService({bool ignoreSSLCertificate = false})
//       : super(ignoreSSLCertificate: ignoreSSLCertificate);
//
//   // Lấy thông tin card theo ID
//   Future<BaseResponse> getCardById(String cardId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/Card/$cardId'),
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
//       print('GetCardById exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Lấy tất cả cards
//   Future<BaseResponse> getAllCards() async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/Card/GetAllCards'),
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
//       print('GetAllCards exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Tạo card mới
//   Future<BaseResponse> createCard(CreateCardDto createCardDto) async {
//     try {
//       final response =
//           await _client.post(Uri.parse('$url_api/api/Card/CreateCard'),
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Accept': 'application/json',
//                 'Authorization': 'Bearer ${Session.token}',
//               },
//               body: jsonEncode(createCardDto.toJson()));
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//     } catch (e) {
//       print('CreateCard exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Cập nhật card
//   Future<BaseResponse> updateCard(UpdateCardDto updateCardDto) async {
//     try {
//       final response = await _client.put(Uri.parse('$url_api/api/Card/Update'),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Bearer ${Session.token}',
//           },
//           body: jsonEncode(updateCardDto.toJson()));
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//     } catch (e) {
//       print('UpdateCard exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Xóa card
//   Future<BaseResponse> deleteCard(String cardId) async {
//     try {
//       final response = await _client.delete(
//         Uri.parse('$url_api/api/Card/Delete/$cardId'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${Session.token}',
//         },
//       );
//
//       if (response.statusCode == 204) {
//         // NoContent response
//         return BaseResponse(
//           Success: true,
//           Message: 'Card deleted successfully',
//         );
//       }
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//     } catch (e) {
//       print('DeleteCard exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
// }
