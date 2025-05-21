import 'dart:convert';

import 'package:http/http.dart' as _client;

import '../../domain/dtos/class_folder_dto.dart';
import '../../domain/models/base-reponse.dart';
import '../../domain/models/session.dart';
import 'BaseService.dart';

class ClassroomFolderService extends BaseService {
  ClassroomFolderService() : super();

  // Helper method to get authorization headers
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (Session.token != null) 'Authorization': 'Bearer ${Session.token}',
    };
  }

  //--------- Assign Folder To ClassRoom ---------
  Future<BaseResponse> assignFolderToClassRoom(AssignClassroomFolderRequest request) async {
    try {
      print('URL API: $url_api');

      final response = await _client.post(
        Uri.parse('$url_api/api/ClassroomFolder/assign'),
        headers: _getHeaders(),
        body: jsonEncode(request.toJson()),
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);

    } catch (e) {
      print('Assign folder to classroom exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  //--------- Get Folders For ClassRoom ---------
  Future<BaseResponse> getFoldersForClassRoom(String classRoomId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/ClassroomFolder/classroom/$classRoomId'),
        headers: _getHeaders(),
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);

    } catch (e) {
      print('Get folders for classroom exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  //--------- Get ClassRooms For Folder ---------
  Future<BaseResponse> getClassRoomsForFolder(String folderId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/ClassroomFolder/folder/$folderId'),
        headers: _getHeaders(),
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);

    } catch (e) {
      print('Get classrooms for folder exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  //--------- Remove Folder From ClassRoom ---------
  Future<BaseResponse> removeFolderFromClassRoom(RemoveClassroomFolderRequest request) async {
    try {
      final response = await _client.delete(
        Uri.parse('$url_api/api/ClassroomFolder/remove'),
        headers: _getHeaders(),
        body: jsonEncode(request.toJson()),
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);

    } catch (e) {
      print('Remove folder from classroom exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }
}