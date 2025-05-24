import 'dart:convert';

import 'package:http/http.dart' as _client;

import '../../domain/dtos/Folder/folder_dto.dart';
import '../../domain/dtos/folder_user/assign_folder_user_request.dart';
import '../../domain/dtos/folder_user/folder_user_dto.dart';
import '../../domain/dtos/folder_user/get_all_folder_by_user.dart';
import '../../domain/dtos/folder_user/remove_folder_user_request.dart';
import '../../domain/models/base-reponse.dart';
import 'BaseService.dart';

class FolderUserService extends BaseService {
  // Constructor - có thể truyền tham số để bỏ qua SSL nếu cần
  FolderUserService({bool ignoreSSLCertificate = false})
      : super(ignoreSSLCertificate: ignoreSSLCertificate);

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // Thêm token authorization nếu cần
  };

  // POST: api/folderuser/assign - Gán folder cho user
  Future<BaseResponse<void>> assignFolderToUserAsync(AssignFolderUserRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse('$url_api/api/folderuser/assign'),
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
    } catch (e) {
      return BaseResponse<void>(
        success: false,
        message: 'Failed to assign folder to user: ${e.toString()}',
        errors: [e.toString()],
      );
    }
  }

  // GET: api/folderuser/user/{userId} - Lấy folders cho một user
  Future<BaseResponse<List<FolderDto>>> getFoldersForUserAsync(String userId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/folderuser/user/$userId'),
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
    } catch (e) {
      return BaseResponse<List<FolderDto>>(
        success: false,
        message: 'Failed to get folders for user: ${e.toString()}',
        errors: [e.toString()],
      );
    }
  }

  // GET: api/folderuser/folder/{folderId} - Lấy users cho một folder
  Future<BaseResponse<List<FolderUserDto>>> getUsersForFolderAsync(String folderId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/folderuser/folder/$folderId'),
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
    } catch (e) {
      return BaseResponse<List<FolderUserDto>>(
        success: false,
        message: 'Failed to get users for folder: ${e.toString()}',
        errors: [e.toString()],
      );
    }
  }

  // GET: api/folderuser/GetAllFoldersByUserId/{userId} - Lấy tất cả folders theo userId
  Future<BaseResponse<List<GetAllFolderByUserIdResponse>>> getAllFoldersByUserIdAsync(String userId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/folderuser/GetAllFoldersByUserId/$userId'),
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
    } catch (e) {
      return BaseResponse<List<GetAllFolderByUserIdResponse>>(
        success: false,
        message: 'Failed to get all folders by user ID: ${e.toString()}',
        errors: [e.toString()],
      );
    }
  }

  // DELETE: api/folderuser/remove - Xóa folder khỏi user
  Future<BaseResponse<void>> removeFolderFromUserAsync(RemoveFolderUserRequest request) async {
    try {
      final response = await _client.delete(
        Uri.parse('$url_api/api/folderuser/remove'),
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
    } catch (e) {
      return BaseResponse<void>(
        success: false,
        message: 'Failed to remove folder from user: ${e.toString()}',
        errors: [e.toString()],
      );
    }
  }
}