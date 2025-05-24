import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as _client;



import '../../domain/dtos/classroom/classroom_dto.dart';
import '../../domain/dtos/classroom/create_classroom_dto.dart';
import '../../domain/dtos/classroom/update_classroom.dart';
import '../../domain/models/base-reponse.dart';
import '../../domain/models/session.dart';
import 'BaseService.dart';

class ClassRoomService extends BaseService {
  ClassRoomService()
      : super();

  // Lấy tất cả lớp học
  Future<BaseResponse<List<ClassRoomDto>>> getAllClassRooms({bool includeDeleted = false}) async {
    final url = Uri.parse('$url_api/api/ClassRoom').replace(
      queryParameters: {
        'includeDeleted': includeDeleted.toString(),
      },
    );

    final response = await _client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu API cần
      },
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<List<ClassRoomDto>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => ClassRoomDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<ClassRoomDto>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load classrooms',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  Future<BaseResponse<ClassRoomDto>> getClassRoomById(String classRoomId) async {
    final url = '$url_api/api/ClassRoom/$classRoomId';

    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return BaseResponse<ClassRoomDto>.fromJson(
          jsonData,
              (data) => ClassRoomDto.fromJson(data as Map<String, dynamic>),
        );
      } else {
        return BaseResponse<ClassRoomDto>(
          success: false,
          message: jsonData['message'] ?? 'Failed to load classroom',
          data: null,
          errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
        );
      }
    } catch (e) {
      return BaseResponse<ClassRoomDto>(
        success: false,
        message: 'Error occurred: $e',
        data: null,
        errors: null,
      );
    }
  }

  // Tạo lớp học mới
  Future<BaseResponse<String>> createClassRoom(CreateClassRoomDto createDto) async {
    final url = '$url_api/api/ClassRoom';

    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần
      },
      body: jsonEncode(createDto.toJson()),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<String>.fromJson(
        jsonData,
            (data) => data as String,
      );
    } else {
      return BaseResponse<String>(
        success: false,
        message: jsonData['message'] ?? 'Failed to create classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  // Cập nhật lớp học
  Future<BaseResponse<String>> updateClassRoom(UpdateClassRoomDto updateDto) async {
    final url = '$url_api/api/ClassRoom/Update';

    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần
      },
      body: jsonEncode(updateDto.toJson()),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<String>.fromJson(
        jsonData,
            (data) => data as String,
      );
    } else {
      return BaseResponse<String>(
        success: false,
        message: jsonData['message'] ?? 'Failed to update classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  Future<BaseResponse<String>> deleteClassRoom(String classRoomId) async {
    final url = '$url_api/api/ClassRoom/$classRoomId';

    final response = await _client.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần
      },
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<String>.fromJson(
        jsonData,
            (data) => data as String,
      );
    } else {
      return BaseResponse<String>(
        success: false,
        message: jsonData['message'] ?? 'Failed to delete classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }


}