


import 'dart:convert';

import '../../domain/dtos/topic/create_topic_dto.dart';
import '../../domain/dtos/topic/topic_dto.dart';
import '../../domain/dtos/topic/update_topic_dto.dart';
import '../../domain/models/base-reponse.dart';
import '../../domain/models/session.dart';
import 'BaseService.dart';
import 'package:http/http.dart' as _client;
class topicService extends BaseService {
  topicService() : super();

  Future<BaseResponse<List<TopicDto>>> getAllTopic() async {
    final url = '$url_api/api/topic';

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
      return BaseResponse<List<TopicDto>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => TopicDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<TopicDto>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load topics',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }
  Future<BaseResponse<TopicDto>> getTopicById(String id) async {
    final url = '$url_api/api/topic/$id';

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
      return BaseResponse<TopicDto>.fromJson(
        jsonData,
            (data) => TopicDto.fromJson(data as Map<String, dynamic>),
      );
    } else {
      return BaseResponse<TopicDto>(
        success: false,
        message: jsonData['message'] ?? 'Failed to load topic',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }
  Future<BaseResponse<CreateTopicDto>> createTopic(CreateTopicDto createDto) async {
    final url = '$url_api/api/topic';

    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần token
      },
      body: jsonEncode(createDto.toJson()),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return BaseResponse<CreateTopicDto>.fromJson(
        jsonData,
            (data) => createDto, // trả về chính createDto vì API trả về nó
      );
    } else {
      return BaseResponse<CreateTopicDto>(
        success: false,
        message: jsonData['message'] ?? 'Failed to create topic',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }

  Future<BaseResponse<UpdateTopicDto>> updateTopic(UpdateTopicDto updateDto) async {
    final url = '$url_api/api/topic/Update';

    final response = await _client.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần token
      },
      body: jsonEncode(updateDto.toJson()),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<UpdateTopicDto>.fromJson(
        jsonData,
            (data) => updateDto, // API trả về updateDto
      );
    } else {
      return BaseResponse<UpdateTopicDto>(
        success: false,
        message: jsonData['message'] ?? 'Failed to update topic',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }
  Future<BaseResponse<Null>> deleteTopic(String id) async {
    if (id.isEmpty) {
      return BaseResponse<Null>(
        success: false,
        message: 'Invalid topic ID.',
        data: null,
        errors: null,
      );
    }

    final url = '$url_api/api/topic/$id';

    final response = await _client.delete(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần token
      },
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
        message: jsonData['message'] ?? 'Failed to delete topic',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }




}