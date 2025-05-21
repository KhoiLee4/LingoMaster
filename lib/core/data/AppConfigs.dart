import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class ApiConfig {
  static final ApiConfig _instance = ApiConfig._internal();
  factory ApiConfig() => _instance;
  ApiConfig._internal();
  
  String _apiUrl = ''; // URL mặc định
  
  String get apiUrl => _apiUrl;
  
  // Load cấu hình từ file config riêng
  Future<void> load() async {
    try {
      // Đọc nội dung file config
      final String yamlString = await rootBundle.loadString('assets/configs/api-config.yaml');
      
      // Parse nội dung YAML
      final YamlMap yamlMap = loadYaml(yamlString);
      
      // Lấy URL API
      if (yamlMap.containsKey('api') && yamlMap['api'] is YamlMap) {
        final apiConfig = yamlMap['api'] as YamlMap;
        if (apiConfig.containsKey('url')) {
          _apiUrl = apiConfig['url'] as String;
        }
      }
    } catch (e) {
      print('Lỗi khi đọc cấu hình: $e');
      // Giữ URL mặc định nếu có lỗi
    }
  }
  
  // Lấy URL đầy đủ cho endpoint
  String getFullUrl(String endpoint) {
    return _apiUrl + endpoint;
  }
}
