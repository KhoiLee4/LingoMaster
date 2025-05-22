import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/dtos/set/create_set_dto.dart';
import '../../domain/dtos/set/set_dto.dart';
import '../../domain/dtos/set/update_set_dto.dart';
import '../../domain/models/base-reponse.dart';

class SetService {
  final String baseUrl;
  final http.Client httpClient;

  SetService({
    required this.baseUrl,
    http.Client? httpClient,
  }) : httpClient = httpClient ?? http.Client();

  /// Dispose method để cleanup resources
  void dispose() {
    httpClient.close();
  }

  /// Headers mặc định cho các request
  Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// GET: api/set - Lấy tất cả sets
  Future<BaseResponse<List<SetDto>>> getAllSets() async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/api/set'),
        headers: _defaultHeaders,
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) {
            final List<dynamic> setList = data as List<dynamic>;
            return setList
                .map((item) => SetDto.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
      } else {
        return BaseResponse<List<SetDto>>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to fetch sets',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<List<SetDto>>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// GET: api/set/{id} - Lấy set theo ID
  Future<BaseResponse<SetDto>> getSetById(String id) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/api/set/$id'),
        headers: _defaultHeaders,
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) => SetDto.fromJson(data as Map<String, dynamic>),
        );
      } else {
        return BaseResponse<SetDto>(
          success: false,
          message: jsonResponse['message'] ?? 'Set not found',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<SetDto>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// GET: api/set/topic/{topicId} - Lấy sets theo Topic ID
  Future<BaseResponse<List<SetDto>>> getSetsByTopicId(String topicId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/api/set/topic/$topicId'),
        headers: _defaultHeaders,
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) {
            final List<dynamic> setList = data as List<dynamic>;
            return setList
                .map((item) => SetDto.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
      } else {
        return BaseResponse<List<SetDto>>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to fetch sets by topic',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<List<SetDto>>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// POST: api/set - Tạo set mới
  Future<BaseResponse<CreateSetDto>> createSet(CreateSetDto createSetDto) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/api/set'),
        headers: _defaultHeaders,
        body: json.encode(createSetDto.toJson()),
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 201 || response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) => CreateSetDto.fromJson(data as Map<String, dynamic>),
        );
      } else {
        return BaseResponse<CreateSetDto>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to create set',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<CreateSetDto>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// PUT: api/set/Update - Cập nhật set
  Future<BaseResponse<UpdateSetDto>> updateSet(UpdateSetDto updateSetDto) async {
    try {
      final response = await httpClient.put(
        Uri.parse('$baseUrl/api/set/Update'),
        headers: _defaultHeaders,
        body: json.encode(updateSetDto.toJson()),
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) => UpdateSetDto.fromJson(data as Map<String, dynamic>),
        );
      } else {
        return BaseResponse<UpdateSetDto>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to update set',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<UpdateSetDto>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// DELETE: api/set/{id} - Xóa set
  Future<BaseResponse<void>> deleteSet(String id) async {
    try {
      final response = await httpClient.delete(
        Uri.parse('$baseUrl/api/set/$id'),
        headers: _defaultHeaders,
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse<void>(
          success: true,
          message: jsonResponse['message'] ?? 'Set deleted successfully',
        );
      } else {
        return BaseResponse<void>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to delete set',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<void>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}