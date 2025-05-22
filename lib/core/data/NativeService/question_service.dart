import 'dart:convert';

import 'package:http/http.dart' as _client;

import '../../domain/dtos/question/multiple_choice_question_dto.dart';
import '../../domain/models/base-reponse.dart';
import '../../domain/models/session.dart';
import 'BaseService.dart';

class QuestionsService extends BaseService {
  QuestionsService () : super();

  Future<BaseResponse<List<MultipleChoiceQuestion>>> generateQuizQuestions(String setId, {int? questions}) async {
    final queryParameters = {
      'setId': setId,
    };
    if (questions != null) {
      queryParameters['questions'] = questions.toString();
    }

    final uri = Uri.parse('$url_api/api/question/generate').replace(queryParameters: queryParameters);

    final response = await _client.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Session.token}', // nếu cần
      },
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse<List<MultipleChoiceQuestion>>.fromJson(
        jsonData,
            (data) => (data as List<dynamic>)
            .map((item) => MultipleChoiceQuestion.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      return BaseResponse<List<MultipleChoiceQuestion>>(
        success: false,
        message: jsonData['message'] ?? 'Failed to generate quiz questions',
        data: null,
        errors: jsonData['errors'] != null ? List<String>.from(jsonData['errors']) : null,
      );
    }
  }}