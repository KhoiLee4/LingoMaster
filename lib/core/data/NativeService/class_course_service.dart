// import 'dart:convert';
//
// import 'package:http/http.dart' as _client;
//
// import '../../domain/dtos/class_course_dto.dart';
// import '../../domain/models/base-reponse.dart';
// import '../../domain/models/session.dart';
// import 'BaseService.dart';
//
// class ClassroomSetService extends BaseService {
//   ClassroomSetService() : super();
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
//   //--------- Assign Set To Classroom ---------
//   Future<BaseResponse> assignSetToClassroom(ClassroomSetDto request) async {
//     try {
//       print('URL API: $url_api');
//
//       final response = await _client.post(
//         Uri.parse('$url_api/api/ClassroomSet/assign'),
//         headers: _getHeaders(),
//         body: jsonEncode(request.toJson()),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Assign set to classroom exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   //--------- Get Sets For Classroom ---------
//   Future<BaseResponse> getSetsForClassroom(String classroomId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/ClassroomSet/classroom/$classroomId'),
//         headers: _getHeaders(),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Get sets for classroom exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   //--------- Get Classrooms For Set ---------
//   Future<BaseResponse> getClassroomsForSet(String setId) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/ClassroomSet/set/$setId'),
//         headers: _getHeaders(),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Get classrooms for set exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   //--------- Remove Set From Classroom ---------
//   Future<BaseResponse> removeSetFromClassroom(ClassroomSetDto request) async {
//     try {
//       final response = await _client.delete(
//         Uri.parse('$url_api/api/ClassroomSet/remove'),
//         headers: _getHeaders(),
//         body: jsonEncode(request.toJson()),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Remove set from classroom exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
// }