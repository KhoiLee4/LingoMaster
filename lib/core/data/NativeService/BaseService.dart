import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lingo_master/core/data/AppConfigs.dart';

class BaseService{
  final String url_api ="http://bao10022004-001-site1.qtempurl.com" ;
  final http.Client _client;
  
  // Constructor với tùy chọn bỏ qua xác minh SSL
  BaseService({bool ignoreSSLCertificate = false}) 
      : _client = ignoreSSLCertificate ? _createInsecureClient() : http.Client();
  
  // Tạo HTTP client bỏ qua xác minh chứng chỉ SSL
  static http.Client _createInsecureClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback = 
          (X509Certificate cert, String host, int port) => true;
    
    return http.Client();
  }
}