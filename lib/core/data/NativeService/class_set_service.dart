import 'dart:convert';
import 'package:http/http.dart' as _client;
import '../../domain/dtos/classroom_set/classroom_set_dto.dart';
import '../../domain/dtos/classroom_user/get_all_set_by_classroom_id_respone.dart';
import '../../domain/models/base-reponse.dart';
import '../../domain/models/session.dart';
import 'BaseService.dart';

class ClassroomSetService extends BaseService {
  ClassroomSetService() : super();

  // Helper method to get authorization headers
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (Session.token != null) 'Authorization': 'Bearer ${Session.token}',
    };
  }

  //--------- Assign Set To Classroom --------- cần check kĩ lại
  Future<BaseResponse<Null>> assignSetToClassroom(ClassroomSetDto request) async {
    final url = '$url_api/api/ClassroomSet/assign';

    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần
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
        message: jsonData['message'] ?? 'Failed to assign set to classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }


  //--------- Get Sets For Classroom ---------
  Future<BaseResponse<List<ClassroomSetDto>>> getSetsForClassroom(String classroomId) async {
    final url = '$url_api/api/ClassroomSet/classroom/$classroomId';

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
      return BaseResponse<List<ClassroomSetDto>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => ClassroomSetDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<ClassroomSetDto>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load sets for classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }


  //--------- Get all set by classroom id ---------
  Future<BaseResponse<List<GetAllSetByClassroomIdRespone>>> getAllSetByClassroomId(String classroomId) async {
    final url = '$url_api/api/ClassroomSet/classroom/$classroomId';

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
      return BaseResponse<List<GetAllSetByClassroomIdRespone>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => GetAllSetByClassroomIdRespone.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<GetAllSetByClassroomIdRespone>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load sets for classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  Future<BaseResponse<List<ClassroomSetDto>>> getClassroomsForSet(String setId) async {
    final url = '$url_api/api/ClassroomSet/classroom/$setId';

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
      return BaseResponse<List<ClassroomSetDto>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => ClassroomSetDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<ClassroomSetDto>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load classrooms for set',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }


  //--------- Remove Set From Classroom ---------
  Future<BaseResponse<String>> removeSetFromClassroom(ClassroomSetDto request) async {
    final url = '$url_api/api/ClassroomSet/remove';

    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần
      },
      body: jsonEncode(request.toJson()),
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
        message: jsonData['message'] ?? 'Failed to remove set from classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

}