class ResponseServices {
  int statusCode;
  dynamic data;
  String message;
  ResponseServices({ required this.statusCode,required this.message, this.data});
  String getResponseMessage(int statusCode) {
    switch (statusCode) {
      case 200:
        return "Success";
      case 400:
        return "Bad Request";
      case 401:
        return "Unauthorized";
      case 403:
        return "Forbidden";
      case 404:
        return "Not Found";
      case 500:
        return "Internal Server Error";
      default:
        return "Unknown Error";
    }
  }

}
class StatusCode{
  static int Success = 200;
  static int BadRequest = 400;
  static int Unauthorized = 401;
  static int Forbidden = 403;
  static int NotFound = 403;
  static int InternalServerError = 500;
  
}