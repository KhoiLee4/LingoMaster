import 'dart:convert';

import 'package:http/http.dart' as http;

class TranslationQuery {
  String fromCode;
  String toCode;
  String translateQuery;

  TranslationQuery({
    required this.fromCode,
    required this.toCode,
    required this.translateQuery,
  });
}

class Translator {
  static Future<String> getTranslation(TranslationQuery query) async {
  final encodedInput = Uri.encodeComponent(query.translateQuery);
  final url =
      'https://translate.googleapis.com/translate_a/single?client=gtx&sl=${query.fromCode}&tl=${query.toCode}&dt=t&q=$encodedInput';

  final response = await http.get(Uri.parse(url));


    if (response.statusCode != 200) {
      return 'Error: ${response.statusCode}';
    }

    final body = response.body;
    if (body.isEmpty) {
      return "Error: Empty response.";
    } else if (body.startsWith('<html')) {
      return "There was something wrong with your request. }";
    }

  final List<dynamic> jsonData = json.decode(response.body);

  final List<dynamic> translationItems = jsonData[0];
  String translation = '';

  for (var item in translationItems) {
    if (item is List && item.isNotEmpty) {
      translation += ' ${item[0]}';
    }
  }
  if (translation.length > 1) {
    translation = translation.substring(1);
  }
  return translation;
  }
}
