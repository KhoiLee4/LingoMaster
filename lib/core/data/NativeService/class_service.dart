import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as _client;
import 'package:lingo_master/core/data/NativeService/BaseService.dart';
import 'package:lingo_master/core/domain/models/base-reponse.dart';
import 'package:lingo_master/core/domain/models/session.dart';

import '../../domain/dtos/class_dto.dart';

class ClassRoomService extends BaseService {
  ClassRoomService({bool ignoreSSLCertificate = false})
      : super(ignoreSSLCertificate: ignoreSSLCertificate);

  // Lấy tất cả lớp học
  Future<BaseResponse> getAllClassRooms({bool includeDeleted = false}) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/ClassRoom?includeDeleted=$includeDeleted'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      print('GetAllClassRooms exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Lấy thông tin lớp học theo ID
  Future<BaseResponse> getClassRoomById(String classRoomId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/ClassRoom/$classRoomId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      print('GetClassRoomById exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Tạo lớp học mới
  Future<BaseResponse> createClassRoom(CreateClassRoomDto createDto) async {
    try {
      final response = await _client.post(
          Uri.parse('$url_api/api/ClassRoom'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Session.token}',
          },
          body: jsonEncode(createDto.toJson())
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      print('CreateClassRoom exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Cập nhật lớp học
  Future<BaseResponse> updateClassRoom(UpdateClassRoomDto updateDto) async {
    try {
      final response = await _client.put(
          Uri.parse('$url_api/api/ClassRoom/Update'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Session.token}',
          },
          body: jsonEncode(updateDto.toJson())
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      print('UpdateClassRoom exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Xóa lớp học
  Future<BaseResponse> deleteClassRoom(String classRoomId) async {
    try {
      final response = await _client.delete(
        Uri.parse('$url_api/api/ClassRoom/$classRoomId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      print('DeleteClassRoom exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Lấy tất cả mã lớp học (để kiểm tra trùng lặp)
  Future<List<String>> getAllClassCodes() async {
    try {
      final response = await getAllClassRooms();
      if (response.Success && response.Data != null) {
        List<dynamic> classroomsJson = response.Data;
        return classroomsJson
            .map((json) => ClassRoomDto.fromJson(json))
            .map((classroom) => classroom.classCode)
            .toList();
      }
      return [];
    } catch (e) {
      print('GetAllClassCodes exception: $e');
      return [];
    }
  }

  // Tạo mã lớp học ngẫu nhiên
  String generateClassCode(int length) {
    const String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final random = Random();
    return String.fromCharCodes(
        Iterable.generate(
            length,
                (_) => chars.codeUnitAt(random.nextInt(chars.length))
        )
    );
  }

  // Tạo lớp học với mã tự động
  Future<BaseResponse> createClassRoomWithAutoCode(CreateClassRoomDto createDto) async {
    try {
      final classCodesList = await getAllClassCodes();
      String classCode;
      do {
        classCode = generateClassCode(6);
      } while (classCodesList.contains(classCode));

      createDto.classCode = classCode;
      return await createClassRoom(createDto);
    } catch (e) {
      print('CreateClassRoomWithAutoCode exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }
}