// class QuestionService {
//   final String baseUrl;
//   final http.Client _client;
//
//   QuestionService({
//     required this.baseUrl,
//     http.Client? client,
//   }) : _client = client ?? http.Client();
//
//   /// Generate quiz questions for a specific set
//   ///
//   /// [setId] - ID của set cần tạo câu hỏi
//   /// [questions] - Số lượng câu hỏi cần tạo (optional)
//   ///
//   /// Returns [BaseResponse<QuizQuestionDto>]
//   Future<BaseResponse<QuizQuestionDto>> generateQuizQuestions({
//     required String setId,
//     int? questions,
//   }) async {
//     try {
//       // Validate setId
//       if (setId.isEmpty) {
//         return BaseResponse<QuizQuestionDto>(
//           success: false,
//           message: 'SetId is required.',
//           errors: ['SetId cannot be empty'],
//         );
//       }
//
//       // Tạo request DTO
//       final requestDto = GenerateQuizRequestDto(
//         setId: setId,
//         questions: questions,
//       );
//
//       // Tạo query parameters
//       final queryParams = requestDto.toQueryParams();
//       final uri = Uri.parse('$baseUrl/api/question/generate')
//           .replace(queryParameters: queryParams);
//
//       // Gửi GET request
//       final response = await _client.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       );
//
//       // Parse response
//       final responseBody = json.decode(response.body);
//
//       if (response.statusCode == 200) {
//         return BaseResponse.fromJson(
//           responseBody,
//               (json) => QuizQuestionDto.fromJson(json as Map<String, dynamic>),
//         );
//       } else {
//         // Handle error responses
//         return BaseResponse<QuizQuestionDto>(
//           success: false,
//           message: responseBody['message'] ?? 'Request failed',
//           errors: responseBody['errors'] != null
//               ? List<String>.from(responseBody['errors'])
//               : ['HTTP ${response.statusCode}: ${response.reasonPhrase}'],
//         );
//       }
//     } catch (e) {
//       return BaseResponse<QuizQuestionDto>(
//         success: false,
//         message: 'Network error occurred',
//         errors: [e.toString()],
//       );
//     }
//   }
//
//   /// Generate quiz questions với các tham số riêng biệt
//   /// (Alternative method signature for convenience)
//   Future<BaseResponse<QuizQuestionDto>> generateQuiz(
//       String setId, [
//         int? questionCount,
//       ]) {
//     return generateQuizQuestions(
//       setId: setId,
//       questions: questionCount,
//     );
//   }
//
//   /// Dispose resources
//   void dispose() {
//     _client.close();
//   }
// }