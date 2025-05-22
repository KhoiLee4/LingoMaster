
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/dtos/Folder/folder_dto.dart';
import '../../domain/dtos/folder_user/assign_folder_user_request.dart';
import '../../domain/dtos/folder_user/folder_user_dto.dart';
import '../../domain/dtos/folder_user/get_all_folder_by_user.dart';
import '../../domain/dtos/folder_user/remove_folder_user_request.dart';
import '../../domain/models/base-reponse.dart';

class FolderUserService {
  final String baseUrl = "http://bao10022004-001-site1.qtempurl.com/api/folderuser";
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // Thêm token authorization nếu cần
  };

  // POST: api/folderuser/assign - Gán folder cho user
  Future<BaseResponse<void>> assignFolderToUserAsync(AssignFolderUserRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/assign'),
      headers: headers,
      body: json.encode(request.toJson()),
    );

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<void>(
        success: jsonResponse['success'] ?? true,
        message: jsonResponse['message'] ?? 'Folder assigned to user successfully.',
      );
    } else {
      return BaseResponse<void>(
        success: false,
        message: 'Failed to assign folder to user. Status code: ${response.statusCode}',
        errors: jsonResponse['errors'] != null
            ? List<String>.from(jsonResponse['errors'])
            : ['Error: ${jsonResponse['message'] ?? 'Unknown error'}'],
      );
    }
  }

  // GET: api/folderuser/user/{userId} - Lấy folders cho một user
  Future<BaseResponse<List<FolderDto>>> getFoldersForUserAsync(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/$userId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<List<FolderDto>>.fromJson(
        jsonResponse,
            (data) => (data as List)
            .map((item) => FolderDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<List<FolderDto>>(
        success: false,
        message: 'Failed to load folders for user. Status code: ${response.statusCode}',
        errors: ['Error: ${jsonResponse['message'] ?? 'Unknown error'}'],
      );
    }
  }

  // GET: api/folderuser/folder/{folderId} - Lấy users cho một folder
  Future<BaseResponse<List<FolderUserDto>>> getUsersForFolderAsync(String folderId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/folder/$folderId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<List<FolderUserDto>>.fromJson(
        jsonResponse,
            (data) => (data as List)
            .map((item) => FolderUserDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<List<FolderUserDto>>(
        success: false,
        message: 'Failed to load users for folder. Status code: ${response.statusCode}',
        errors: ['Error: ${jsonResponse['message'] ?? 'Unknown error'}'],
      );
    }
  }

  // GET: api/folderuser/GetAllFoldersByUserId/{userId} - Lấy tất cả folders theo userId
  Future<BaseResponse<List<GetAllFolderByUserIdResponse>>> getAllFoldersByUserIdAsync(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/GetAllFoldersByUserId/$userId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<List<GetAllFolderByUserIdResponse>>.fromJson(
        jsonResponse,
            (data) => (data as List)
            .map((item) => GetAllFolderByUserIdResponse.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<List<GetAllFolderByUserIdResponse>>(
        success: false,
        message: 'Failed to load all folders by user ID. Status code: ${response.statusCode}',
        errors: ['Error: ${jsonResponse['message'] ?? 'Unknown error'}'],
      );
    }
  }

  // DELETE: api/folderuser/remove - Xóa folder khỏi user
  Future<BaseResponse<void>> removeFolderFromUserAsync(RemoveFolderUserRequest request) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/remove'),
      headers: headers,
      body: json.encode(request.toJson()),
    );

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<void>(
        success: jsonResponse['success'] ?? true,
        message: jsonResponse['message'] ?? 'Removed folder from user successfully.',
      );
    } else {
      return BaseResponse<void>(
        success: false,
        message: 'Failed to remove folder from user. Status code: ${response.statusCode}',
        errors: jsonResponse['errors'] != null
            ? List<String>.from(jsonResponse['errors'])
            : ['Error: ${jsonResponse['message'] ?? 'Unknown error'}'],
      );
    }
  }
}