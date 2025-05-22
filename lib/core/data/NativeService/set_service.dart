// import 'dart:convert';
//
// import 'package:http/http.dart' as _client;
//
// import '../../domain/dtos/set_dto.dart';
// import '../../domain/models/base-reponse.dart';
// import '../../domain/models/session.dart';
// import 'BaseService.dart';
//
// class SetService extends BaseService {
//   SetService() : super();
//
//   // Get all sets
//   Future<BaseResponse> getAllSets() async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/Set'),
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
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Get set by ID
//   Future<BaseResponse> getSetById(String id) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/Set/$id'),
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
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Get sets by topic ID
//   Future<BaseResponse> getSetsByTopicId(String topicId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/Set/topic/$topicId'),
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
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Create new set
//   Future<BaseResponse> createSet(CreateSetDto createDto) async {
//     try {
//       final response = await _client.post(
//         Uri.parse('$url_api/api/Set'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${Session.token}',
//         },
//         body: jsonEncode(createDto.toJson()),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//     } catch (e) {
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Update set
//   Future<BaseResponse> updateSet(UpdateSetDto updateDto) async {
//     try {
//       final response = await _client.put(
//         Uri.parse('$url_api/api/Set/Update'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${Session.token}',
//         },
//         body: jsonEncode(updateDto.toJson()),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//     } catch (e) {
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Delete set
//   Future<BaseResponse> deleteSet(String id) async {
//     try {
//       final response = await _client.delete(
//         Uri.parse('$url_api/api/Set/$id'),
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
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   // Utility method to parse the response data into SetDto objects
//   List<SetDto> parseSetList(dynamic data) {
//     if (data == null) return [];
//
//     List<dynamic> items = data is List ? data : [data];
//     return items.map((item) => SetDto.fromJson(item)).toList();
//   }
// }