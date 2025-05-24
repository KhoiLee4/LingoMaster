import 'dart:convert';

import 'package:http/http.dart' as _client;

import '../../domain/dtos/folder_set/folder_set_dto.dart';
import '../../domain/dtos/folder_set/get_all_set_by_folder.dart';
import '../../domain/models/base-reponse.dart';
import 'BaseService.dart';


class FolderSetService extends BaseService {
  // Constructor - có thể truyền tham số để bỏ qua SSL nếu cần
  FolderSetService({bool ignoreSSLCertificate = false})
      : super(ignoreSSLCertificate: ignoreSSLCertificate);

  // Assign a set to a folder
  Future<BaseResponse<void>> assignSetToFolder(FolderSetDto request) async {
    try {
      final response = await _client.post(
        Uri.parse('$url_api/api/FolderSet/assign'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);
      return BaseResponse<void>.fromJson(
        responseData,
            (_) => null, // No data to parse for void return type
      );
    } catch (e) {
      return BaseResponse<void>(
        success: false,
        message: 'Failed to assign set to folder: ${e.toString()}',
        errors: [e.toString()],
      );
    }
  }

  // Get all sets for a specific folder
  Future<BaseResponse<List<dynamic>>> getSetsForFolder(String folderId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/FolderSet/folder/$folderId'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);
      return BaseResponse<List<dynamic>>.fromJson(
        responseData,
            (data) => data != null ? List<dynamic>.from(data as List) : [],
      );
    } catch (e) {
      return BaseResponse<List<dynamic>>(
        success: false,
        message: 'Failed to get sets for folder: ${e.toString()}',
        errors: [e.toString()],
      );
    }
  }

  // Get all folders for a specific set
  Future<BaseResponse<List<dynamic>>> getFoldersForSet(String setId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/FolderSet/set/$setId'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);
      return BaseResponse<List<dynamic>>.fromJson(
        responseData,
            (data) => data != null ? List<dynamic>.from(data as List) : [],
      );
    } catch (e) {
      return BaseResponse<List<dynamic>>(
        success: false,
        message: 'Failed to get folders for set: ${e.toString()}',
        errors: [e.toString()],
      );
    }
  }

  // Get all sets by folder ID with detailed information
  Future<BaseResponse<List<GetAllSetsByFolderIdResponse>>> getAllSetsByFolderId(String folderId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/FolderSet/GetAllSetsByFolderId/$folderId'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);
      return BaseResponse<List<GetAllSetsByFolderIdResponse>>.fromJson(
        responseData,
            (data) {
          if (data == null) return [];
          final list = data as List;
          return list.map((item) => GetAllSetsByFolderIdResponse.fromJson(item)).toList();
        },
      );
    } catch (e) {
      return BaseResponse<List<GetAllSetsByFolderIdResponse>>(
        success: false,
        message: 'Failed to get all sets by folder ID: ${e.toString()}',
        errors: [e.toString()],
      );
    }
  }

  // Remove a set from a folder
  Future<BaseResponse<void>> removeSetFromFolder(FolderSetDto request) async {
    try {
      final response = await _client.delete(
        Uri.parse('$url_api/api/FolderSet/remove'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);
      return BaseResponse<void>.fromJson(
        responseData,
            (_) => null, // No data to parse for void return type
      );
    } catch (e) {
      return BaseResponse<void>(
        success: false,
        message: 'Failed to remove set from folder: ${e.toString()}',
        errors: [e.toString()],
      );
    }
  }
}