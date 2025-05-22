// import 'dart:convert';
//
// import 'package:http/http.dart' as _client;
//
// import '../../domain/dtos/set_user_dto.dart';
// import '../../domain/models/base-reponse.dart';
// import '../../domain/models/session.dart';
// import 'BaseService.dart';
//
// class SetUserService extends BaseService {
//   SetUserService() : super();
//
//   // Assign a set to a user
//   Future<BaseResponse> assignSetToUser(AssignSetUserRequest request) async {
//     try {
//       final response = await _client.post(
//         Uri.parse('$url_api/api/SetUser/assign'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${Session.token}',
//         },
//         body: jsonEncode(request.toJson()),
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
//   // Update access date
//   Future<BaseResponse> updateAccessDate(UpdateAccessDateRequest request) async {
//     try {
//       final response = await _client.put(
//         Uri.parse('$url_api/api/SetUser/updateaccess'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${Session.token}',
//         },
//         body: jsonEncode(request.toJson()),
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
//   // Get sets for a specific user
//   Future<BaseResponse> getSetsForUser(String userId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/SetUser/user/$userId'),
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
//   // Get all sets owned by a user
//   Future<BaseResponse> getSetsOwnerForUser(String userId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/SetUser/getAllSetsOwner/$userId'),
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
//   // Get users for a specific set
//   Future<BaseResponse> getUsersForSet(String setId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/SetUser/set/$setId'),
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
//   // Remove a set from a user
//   Future<BaseResponse> removeSetFromUser(RemoveSetUserRequest request) async {
//     try {
//       final requestOptions = {
//         'method': 'DELETE',
//         'headers': {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${Session.token}',
//         },
//         'body': jsonEncode(request.toJson()),
//       };
//
//       final response = await _client.delete(
//         Uri.parse('$url_api/api/SetUser/remove'),
//         headers: requestOptions['headers'] as Map<String, String>,
//         body: requestOptions['body'] as String,
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
//   // Utility method to parse the response data into SetUserDto objects
//   List<SetUserDto> parseSetUserList(dynamic data) {
//     if (data == null) return [];
//
//     List<dynamic> items = data is List ? data : [data];
//     return items.map((item) => SetUserDto.fromJson(item)).toList();
//   }
// }