import 'dart:convert';

import 'package:http/http.dart' as _client;

import '../../domain/dtos/folder_user_dto.dart';
import '../../domain/models/base-reponse.dart';
import '../../domain/models/session.dart';
import 'BaseService.dart';

class FolderUserService extends BaseService {
  FolderUserService() : super();

  // Assign a folder to a user
  Future<BaseResponse> assignFolderToUser(AssignFolderUserRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse('$url_api/api/FolderUser/assign'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
        body: jsonEncode(request.toJson()),
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Get folders for a specific user
  Future<BaseResponse> getFoldersForUser(String userId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/FolderUser/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Get users for a specific folder
  Future<BaseResponse> getUsersForFolder(String folderId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/FolderUser/folder/$folderId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Remove a folder from a user
  Future<BaseResponse> removeFolderFromUser(RemoveFolderUserRequest request) async {
    try {
      final response = await _client.delete(
        Uri.parse('$url_api/api/FolderUser/remove'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
        body: jsonEncode(request.toJson()),
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }
}