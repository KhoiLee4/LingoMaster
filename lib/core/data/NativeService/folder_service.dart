
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/dtos/Folder/create_folder_dto.dart';
import '../../domain/dtos/Folder/folder_dto.dart';
import '../../domain/dtos/Folder/update_folder_dto.dart';
import '../../domain/models/base-reponse.dart';

class FolderService {
  final String baseUrl = "http://bao10022004-001-site1.qtempurl.com/api/folder";
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // Thêm token authorization nếu cần
  };

  // GET: api/folder - Lấy tất cả các folder
  Future<BaseResponse<List<FolderDto>>> getAllFoldersAsync({bool includeDeleted = false}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?includeDeleted=$includeDeleted'),
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
        message: 'Failed to load folders. Status code: ${response.statusCode}',
        errors: ['Error: ${jsonResponse['message'] ?? 'Unknown error'}'],
      );
    }
  }

  // GET: api/folder/{id} - Lấy folder theo ID
  Future<BaseResponse<FolderDto>> getFolderByIdAsync(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<FolderDto>.fromJson(
        jsonResponse,
            (data) => FolderDto.fromJson(data as Map<String, dynamic>),
      );
    } else {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<FolderDto>(
        success: false,
        message: 'Failed to load folder. Status code: ${response.statusCode}',
        errors: ['Error: ${jsonResponse['message'] ?? 'Unknown error'}'],
      );
    }
  }

  // POST: api/folder - Tạo folder mới
  Future<BaseResponse<CreateFolderDto>> createFolderAsync(CreateFolderDto createDto) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: json.encode(createDto.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<CreateFolderDto>.fromJson(
        jsonResponse,
            (data) => CreateFolderDto.fromJson(data as Map<String, dynamic>),
      );
    } else {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<CreateFolderDto>(
        success: false,
        message: 'Failed to create folder. Status code: ${response.statusCode}',
        errors: jsonResponse['errors'] != null
            ? List<String>.from(jsonResponse['errors'])
            : ['Unknown error'],
      );
    }
  }

  // PUT: api/folder/Update - Cập nhật folder
  Future<BaseResponse<UpdateFolderDto>> updateFolderAsync(UpdateFolderDto updateDto) async {
    final response = await http.put(
      Uri.parse('$baseUrl/Update'),
      headers: headers,
      body: json.encode(updateDto.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<UpdateFolderDto>.fromJson(
        jsonResponse,
            (data) => UpdateFolderDto.fromJson(data as Map<String, dynamic>),
      );
    } else {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<UpdateFolderDto>(
        success: false,
        message: 'Failed to update folder. Status code: ${response.statusCode}',
        errors: jsonResponse['errors'] != null
            ? List<String>.from(jsonResponse['errors'])
            : ['Unknown error'],
      );
    }
  }

  // DELETE: api/folder/{id} - Xóa folder
  Future<BaseResponse<void>> deleteFolderAsync(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<void>(
        success: jsonResponse['success'] ?? false,
        message: jsonResponse['message'] ?? 'Folder deleted successfully',
      );
    } else {
      final jsonResponse = json.decode(response.body);
      return BaseResponse<void>(
        success: false,
        message: 'Failed to delete folder. Status code: ${response.statusCode}',
        errors: jsonResponse['errors'] != null
            ? List<String>.from(jsonResponse['errors'])
            : ['Unknown error'],
      );
    }
  }
}