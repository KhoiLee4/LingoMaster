class BaseResponse {
  bool Success;
  String Message;
  dynamic Data;
  List<String>? Errors;

  BaseResponse({
    this.Success = false,
    this.Message = '',
    this.Data,
    this.Errors,
  });

  // Phương thức fromJson để tạo đối tượng từ Map
  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    // Xử lý trường errors
    List<String>? errorsList;
    if (json['errors'] != null) {
      if (json['errors'] is List) {
        errorsList = (json['errors'] as List).map((e) => e.toString()).toList();
      }
    }

    return BaseResponse(
      Success: json['success'] ?? false,
      Message: json['message'] ?? '',
      Data: json['data'],
      Errors: errorsList,
    );
  }
}