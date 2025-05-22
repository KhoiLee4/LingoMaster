class BaseResponse<T> {
  bool success;
  String message;
  T? data;
  List<String>? errors;

  BaseResponse({required this.success, required this.message, this.data, this.errors});

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return BaseResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      errors: json['errors'] != null
          ? List<String>.from(json['errors'])
          : null,
    );
  }
}