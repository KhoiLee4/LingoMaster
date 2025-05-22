// import 'dart:convert';
//
// import 'package:http/http.dart' as _client;
//
// import '../../domain/dtos/folder_dto.dart';
// import '../../domain/models/base-reponse.dart';
// import '../../domain/models/session.dart';
// import 'BaseService.dart';
//
// class FolderService extends BaseService {
//   FolderService() : super();
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
//   //--------- Get All Folders ---------
//   Future<BaseResponse> getAllFolders({bool includeDeleted = false}) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/Folder?includeDeleted=$includeDeleted'),
//         headers: _getHeaders(),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Get all folders exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//
//       );
//     }
//   }
//
//   //--------- Get Folder By Id ---------
//   Future<BaseResponse> getFolderById(String id) async {
//     try {
//       final response = await _client.get(
//         Uri.parse('$url_api/api/Folder/$id'),
//         headers: _getHeaders(),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Get folder by id exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   //--------- Create Folder ---------
//   Future<BaseResponse> createFolder(CreateFolderDto createDto) async {
//     try {
//       print('URL API: $url_api');
//
//       final response = await _client.post(
//         Uri.parse('$url_api/api/Folder'),
//         headers: _getHeaders(),
//         body: jsonEncode(createDto.toJson()),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Create folder exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   //--------- Update Folder ---------
//   Future<BaseResponse> updateFolder(UpdateFolderDto updateDto) async {
//     try {
//       final response = await _client.put(
//         Uri.parse('$url_api/api/Folder/Update'),
//         headers: _getHeaders(),
//         body: jsonEncode(updateDto.toJson()),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Update folder exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
//
//   //--------- Delete Folder ---------
//   Future<BaseResponse> deleteFolder(String id) async {
//     try {
//       final response = await _client.delete(
//         Uri.parse('$url_api/api/Folder/$id'),
//         headers: _getHeaders(),
//       );
//
//       final Map<String, dynamic> jsonData = jsonDecode(response.body);
//       return BaseResponse.fromJson(jsonData);
//
//     } catch (e) {
//       print('Delete folder exception: $e');
//       return BaseResponse(
//         Success: false,
//         Message: 'Connection error: ${e.toString()}',
//       );
//     }
//   }
// }