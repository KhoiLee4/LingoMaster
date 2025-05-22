import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/dtos/set_user/assign_set_user_request.dart';
import '../../domain/dtos/set_user/created_set_dto.dart';
import '../../domain/dtos/set_user/remove_set_user_request.dart';
import '../../domain/dtos/set_user/set_user_dto.dart';
import '../../domain/dtos/set_user/update_access_date_request.dart';
import '../../domain/models/base-reponse.dart';

class SetUserService {
  final String baseUrl;
  final http.Client httpClient;

  SetUserService({
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

  /// POST: api/setuser/assign - Gán set cho user
  Future<BaseResponse<void>> assignSetToUser(AssignSetUserRequest request) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/api/setuser/assign'),
        headers: _defaultHeaders,
        body: json.encode(request.toJson()),
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse<void>(
          success: true,
          message: jsonResponse['message'] ?? 'Assigned set to user successfully',
        );
      } else {
        return BaseResponse<void>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to assign set to user',
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

  /// PUT: api/setuser/updateaccess - Cập nhật ngày truy cập
  Future<BaseResponse<void>> updateAccessDate(UpdateAccessDateRequest request) async {
    try {
      final response = await httpClient.put(
        Uri.parse('$baseUrl/api/setuser/updateaccess'),
        headers: _defaultHeaders,
        body: json.encode(request.toJson()),
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse<void>(
          success: true,
          message: jsonResponse['message'] ?? 'Access date updated successfully',
        );
      } else {
        return BaseResponse<void>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to update access date',
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

  /// GET: api/setuser/user/{userId} - Lấy sets cho user
  Future<BaseResponse<List<CreatedSetDto>>> getSetsForUser(String userId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/api/setuser/user/$userId'),
        headers: _defaultHeaders,
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) {
            final List<dynamic> setList = data as List<dynamic>;
            return setList
                .map((item) => CreatedSetDto.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
      } else {
        return BaseResponse<List<CreatedSetDto>>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to fetch sets for user',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<List<CreatedSetDto>>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// GET: api/setuser/getAllSetsOwner/{userId} - Lấy tất cả sets mà user là owner
  Future<BaseResponse<List<CreatedSetDto>>> getAllSetsOwner(String userId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/api/setuser/getAllSetsOwner/$userId'),
        headers: _defaultHeaders,
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) {
            final List<dynamic> setList = data as List<dynamic>;
            return setList
                .map((item) => CreatedSetDto.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
      } else {
        return BaseResponse<List<CreatedSetDto>>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to fetch owner sets',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<List<CreatedSetDto>>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// GET: api/setuser/set/{setId} - Lấy users cho set
  Future<BaseResponse<List<SetUserDto>>> getUsersForSet(String setId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/api/setuser/set/$setId'),
        headers: _defaultHeaders,
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) {
            final List<dynamic> userList = data as List<dynamic>;
            return userList
                .map((item) => SetUserDto.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
      } else {
        return BaseResponse<List<SetUserDto>>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to fetch users for set',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<List<SetUserDto>>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// GET: api/setuser/getAllSetsJoined/{userId} - Lấy tất cả sets mà user đã join
  Future<BaseResponse<List<CreatedSetDto>>> getAllSetsJoined(String userId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/api/setuser/getAllSetsJoined/$userId'),
        headers: _defaultHeaders,
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) {
            final List<dynamic> setList = data as List<dynamic>;
            return setList
                .map((item) => CreatedSetDto.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
      } else {
        return BaseResponse<List<CreatedSetDto>>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to fetch joined sets',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<List<CreatedSetDto>>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// GET: api/setuser/owner/{userId}/{setId} - Kiểm tra user có phải owner của set
  Future<BaseResponse<bool>> isUserOwnerOfSet(String userId, String setId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/api/setuser/owner/$userId/$setId'),
        headers: _defaultHeaders,
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) => data as bool,
        );
      } else {
        return BaseResponse<bool>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to check ownership',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<bool>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// GET: api/setuser/allsets/{userId} - Lấy tất cả sets của user
  Future<BaseResponse<List<CreatedSetDto>>> getAllSetsByUserId(String userId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/api/setuser/allsets/$userId'),
        headers: _defaultHeaders,
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          jsonResponse,
              (data) {
            final List<dynamic> setList = data as List<dynamic>;
            return setList
                .map((item) => CreatedSetDto.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
      } else {
        return BaseResponse<List<CreatedSetDto>>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to fetch all sets for user',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return BaseResponse<List<CreatedSetDto>>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// DELETE: api/setuser/remove - Xóa set khỏi user
  Future<BaseResponse<void>> removeSetFromUser(RemoveSetUserRequest request) async {
    try {
      final response = await httpClient.delete(
        Uri.parse('$baseUrl/api/setuser/remove'),
        headers: _defaultHeaders,
        body: json.encode(request.toJson()),
      );

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return BaseResponse<void>(
          success: true,
          message: jsonResponse['message'] ?? 'Removed set from user successfully',
        );
      } else {
        return BaseResponse<void>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to remove set from user',
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