
import 'dart:convert';

import 'package:http/http.dart' as _client;

import '../../domain/dtos/set_user/assign_set_user_request.dart';
import '../../domain/dtos/set_user/created_set_dto.dart';
import '../../domain/dtos/set_user/remove_set_user_request.dart';
import '../../domain/dtos/set_user/set_user_dto.dart';
import '../../domain/dtos/set_user/update_access_date_request.dart';
import '../../domain/models/base-reponse.dart';
import 'BaseService.dart';

class SetUserService extends BaseService {
  SetUserService({bool ignoreSSLCertificate = false})
      : super(ignoreSSLCertificate: ignoreSSLCertificate);

  /// Dispose method to cleanup resources
  // void dispose() {
  //   _client.close();
  // }

  /// Headers for requests
  Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// POST: api/setuser/assign - Assign set to user
  Future<BaseResponse<void>> assignSetToUser(AssignSetUserRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse('$url_api/api/setuser/assign'),
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

  /// PUT: api/setuser/updateaccess - Update access date
  Future<BaseResponse<void>> updateAccessDate(UpdateAccessDateRequest request) async {
    try {
      final response = await _client.put(
        Uri.parse('$url_api/api/setuser/updateaccess'),
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

  /// GET: api/setuser/user/{userId} - Get sets for user
  Future<BaseResponse<List<CreatedSetDto>>> getSetsForUser(String userId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/setuser/user/$userId'),
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

  /// GET: api/setuser/getAllSetsOwner/{userId} - Get all sets where user is owner
  Future<BaseResponse<List<CreatedSetDto>>> getAllSetsOwner(String userId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/setuser/getAllSetsOwner/$userId'),
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

  /// GET: api/setuser/set/{setId} - Get users for set
  Future<BaseResponse<List<SetUserDto>>> getUsersForSet(String setId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/setuser/set/$setId'),
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

  /// GET: api/setuser/getAllSetsJoined/{userId} - Get all sets user has joined
  Future<BaseResponse<List<CreatedSetDto>>> getAllSetsJoined(String userId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/setuser/getAllSetsJoined/$userId'),
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

  /// GET: api/setuser/owner/{userId}/{setId} - Check if user is owner of set
  Future<BaseResponse<bool>> isUserOwnerOfSet(String userId, String setId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/setuser/owner/$userId/$setId'),
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

  /// GET: api/setuser/allsets/{userId} - Get all sets for user
  Future<BaseResponse<List<CreatedSetDto>>> getAllSetsByUserId(String userId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/setuser/allsets/$userId'),
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

  /// DELETE: api/setuser/remove - Remove set from user
  Future<BaseResponse<void>> removeSetFromUser(RemoveSetUserRequest request) async {
    try {
      final response = await _client.delete(
        Uri.parse('$url_api/api/setuser/remove'),
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