import 'dart:convert';

import 'package:http/http.dart' as _client;

import '../../domain/dtos/class_folder/assign_classroom_folder_request.dart';
import '../../domain/dtos/class_folder/classroom_folder_dto.dart';
import '../../domain/dtos/class_folder/get_all_folder_by_classroom_Id_respone.dart';
import '../../domain/dtos/class_folder/remove_classroom_folder_request.dart';

import '../../domain/models/base-reponse.dart';
import '../../domain/models/session.dart';
import 'BaseService.dart';

class ClassroomFolderService extends BaseService {
  ClassroomFolderService() : super();

  // Helper method to get authorization headers
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (Session.token != null) 'Authorization': 'Bearer ${Session.token}',
    };
  }

  //--------- Assign Folder To ClassRoom ---------

  Future<BaseResponse<Null>> assignFolderToClassRoom(AssignClassroomFolderRequest request) async {
    final url = '$url_api/api/ClassroomFolder/assign';

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
        message: jsonData['message'] ?? 'Failed to assign folder to classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  //--------- Get Folders For ClassRoom ---------
  Future<BaseResponse<List<ClassroomFolderDto>>> getFoldersForClassRoom(String classRoomId) async {
    final url = '$url_api/api/ClassroomFolder/classroom/$classRoomId';

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
      return BaseResponse<List<ClassroomFolderDto>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => ClassroomFolderDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<ClassroomFolderDto>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load folders for classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  Future<BaseResponse<List<GetAllFolderByClassroomIdRespone>>> getAllFolderByClassroomId(String classroomId) async {
    final url = '$url_api/api/ClassroomFolder/GetAllFolderByClassroomId/$classroomId';

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
      return BaseResponse<List<GetAllFolderByClassroomIdRespone>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => GetAllFolderByClassroomIdRespone.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<GetAllFolderByClassroomIdRespone>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load folders by classroom ID',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  //--------- Get ClassRooms For Folder ---------
  Future<BaseResponse<List<ClassroomFolderDto>>> getClassRoomsForFolder(String folderId) async {
    final url = '$url_api/api/ClassroomFolder/folder/$folderId';

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
      return BaseResponse<List<ClassroomFolderDto>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => ClassroomFolderDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<ClassroomFolderDto>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load classrooms for folder',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }


  //--------- Remove Folder From ClassRoom ---------
  Future<BaseResponse<Null>> removeFolderFromClassRoom(RemoveClassroomFolderRequest request) async {
    final url = '$url_api/api/ClassroomFolder/remove';

    final requestBody = jsonEncode(request.toJson());

    final response = await _client.delete(
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
        message: jsonData['message'] ?? 'Failed to remove folder from classroom',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

}