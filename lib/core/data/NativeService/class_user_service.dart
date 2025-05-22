// import 'dart:convert';
//
// import 'package:http/http.dart' as _client;
//
// import '../../domain/dtos/class_user_dto.dart';
// import '../../domain/models/base-reponse.dart';
// import '../../domain/models/session.dart';
// import 'BaseService.dart';
//
// class ClassRoomUserService extends BaseService {
//   ClassRoomUserService() : super();
//
//   // Helper method to get authorization headers
//   Map<String, String> _getHeaders() {
//     return {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       if (Session.token != null) 'Authorization': 'Bearer ${Session.token}',
//     };
//   }
//
//   //--------- Assign User To ClassRoom ---------
//   Future<BaseResponse> assignUserToClassRoom(AssignClassRoomUserDto request) async {
//     try {
//       print('URL API: $url_api');
//
//       final response = await _client.post(
//         Uri.parse('$url_api/api/ClassRoomUser/assign'),
//         headers: _getHeaders(),
//         body: jsonEncode(request.toJson()),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Assign user to classroom exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   //--------- Get Users For ClassRoom ---------
//   Future<BaseResponse> getUsersForClassRoom(String classRoomId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/ClassRoomUser/classroom/$classRoomId'),
//         headers: _getHeaders(),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Get users for classroom exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   //--------- Get ClassRooms For User ---------
//   Future<BaseResponse> getClassRoomsForUser(String userId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/ClassRoomUser/user/$userId'),
//         headers: _getHeaders(),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Get classrooms for user exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   //--------- Remove User From ClassRoom ---------
//   Future<BaseResponse> removeUserFromClassRoom(RemoveClassRoomUserDto request) async {
//     try {
//       final response = await _client.delete(
//         Uri.parse('$url_api/api/ClassRoomUser/remove'),
//         headers: _getHeaders(),
//         body: jsonEncode(request.toJson()),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Remove user from classroom exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   //--------- Check If User Is Owner Of ClassRoom ---------
//   Future<BaseResponse> isUserOwnerOfClassRoom(String classRoomId, String userId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/ClassRoomUser/owner/$classRoomId/$userId'),
//         headers: _getHeaders(),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Check user owner exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
// }