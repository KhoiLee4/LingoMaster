import 'dart:convert';

import 'package:http/http.dart' as _client;

import '../../domain/dtos/classroom_set/assign_class_room_user_dto.dart';
import '../../domain/dtos/classroom_user/classroom_user_dto.dart';
import '../../domain/dtos/classroom_user/get_all_class_by_user_id_respone.dart';
import '../../domain/dtos/classroom_user/get_all_infor_class_joined_by_userId_respone.dart';
import '../../domain/dtos/classroom_user/remove_classroom_user_dto.dart';
import '../../domain/models/base-reponse.dart';
import '../../domain/models/session.dart';
import 'BaseService.dart';

class ClassRoomUserService extends BaseService {
  ClassRoomUserService() : super();

  // Helper method to get authorization headers
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (Session.token != null) 'Authorization': 'Bearer ${Session.token}',
    };
  }

  //--------- Assign User To ClassRoom ---------
  Future<BaseResponse<Null>> assignUserToClassRoom(AssignClassRoomUserDto request) async {
    final url = '$url_api/api/ClassRoomUser/assign';

    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần token
      },
      body: jsonEncode(request.toJson()),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<Null>.fromJson(
        jsonData,
            (data) => null,
      );
    } else {
      return BaseResponse<Null>(
        success: false,
        message: jsonData['message'] ?? 'Failed to assign user to classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  Future<BaseResponse<List<GetAllClassByUserIdRespone>>> getAllClassByUserId(String userId) async {
    final url = '$url_api/api/classroomuser/GetAllClassByUserId/$userId';

    final response = await _client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu API cần
      },
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<List<GetAllClassByUserIdRespone>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => GetAllClassByUserIdRespone.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<GetAllClassByUserIdRespone>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load classes by user id',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }


  //--------- Get Users For ClassRoom ---------
  Future<BaseResponse<List<ClassRoomUserDto>>> getUsersForClassRoom(String classRoomId) async {
    final url = '$url_api/api/ClassRoomUser/classroom/$classRoomId';

    final response = await _client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần token
      },
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<List<ClassRoomUserDto>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => ClassRoomUserDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<ClassRoomUserDto>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load users for classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }


  //--------- Get ClassRooms For User ---------
  Future<BaseResponse<List<ClassRoomUserDto>>> getClassRoomsForUser(String userId) async {
    final url = '$url_api/classroomuser/user/$userId';

    final response = await _client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần token
      },
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<List<ClassRoomUserDto>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => ClassRoomUserDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<ClassRoomUserDto>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load classrooms for user',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }


  //--------- Remove User From ClassRoom ---------
  Future<BaseResponse<Null>> removeUserFromClassRoom(RemoveClassRoomUserDto request) async {
    final url = '$url_api/api/ClassRoomUser/remove';

    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu API cần token
      },
      body: jsonEncode(request.toJson()),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<Null>.fromJson(
        jsonData,
            (data) => null,
      );
    } else {
      return BaseResponse<Null>(
        success: false,
        message: jsonData['message'] ?? 'Failed to remove user from classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  Future<BaseResponse<List<GetAllInforClassJoinedByUserIdRespone>>> getAllInforClassJoinedByUserId(String userId) async {
    final url = '$url_api/api/classroomuser/allinforclassjoined/$userId';

    final response = await _client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần
      },
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<List<GetAllInforClassJoinedByUserIdRespone>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => GetAllInforClassJoinedByUserIdRespone.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<GetAllInforClassJoinedByUserIdRespone>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load joined classes',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  //--------- Check If User Is Owner Of ClassRoom ---------
  Future<BaseResponse<bool>> isUserOwnerOfClassRoom(String classRoomId, String userId) async {
    final url = '$url_api/api/ClassRoomUser/owner/$classRoomId/$userId';

    final response = await _client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần
      },
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<bool>.fromJson(
        jsonData,
            (data) => data as bool,
      );
    } else {
      return BaseResponse<bool>(
        success: false,
        message: jsonData['message'] ?? 'Failed to check ownership',
        data: false,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

}