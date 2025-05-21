// import 'package:free_dictionary_api_v2/free_dictionary_api_v2.dart';
// import 'package:lingo_master/core/data/ResponseServies/ResponseServices.dart';

// class Dictionary {
//   static Future<ResponseServices> getWordDetails(String word) async {
//     if (word.trim().isEmpty) {
//       return ResponseServices(
//         statusCode: StatusCode.BadRequest, 
//         data: "", 
//         message: "Word cannot be empty"
//       );
//     }

//     try {
//       final dictionary = FreeDictionaryApiV2();
//       final response = await dictionary.getDefinition(word);

//       if (response.isEmpty) {
//         return ResponseServices(
//           statusCode: StatusCode.NotFound, 
//           data: null, 
//           message: "Word not found"
//         );
//       }

//       final wordData = response.first;

//       // Tìm phát âm có âm thanh
//       String? phonetic;
//       String? audioUrl;
      
//       if (wordData.phonetics != null && wordData.phonetics!.isNotEmpty) {
//         for (var phon in wordData.phonetics!) {
//           if (phon.text != null && phon.text!.isNotEmpty) {
//             phonetic = phon.text;
//             if (phon.audio != null && phon.audio!.isNotEmpty) {
//               audioUrl = phon.audio;
//               break; // Ưu tiên lấy phát âm có cả text và audio
//             }
//           }
//         }
        
//         // Nếu không tìm thấy cả text và audio, chỉ lấy text
//         if (phonetic == null) {
//           phonetic = wordData.phonetics!.firstWhere(
//             (p) => p.text != null && p.text!.isNotEmpty,
//             orElse: () => Phonetic(text: null)
//           ).text;
//         }
//       }

//       WordDetails wordDetails = WordDetails(
//         word: wordData.word,
//         phonetics: phonetic,
//         audioUrl: audioUrl,
//       );

//       List<PartOfSpeech> partOfSpeechList = [];
//       for (var meaning in wordData.meanings ?? []) {
//         if (meaning.definitions != null && meaning.definitions!.isNotEmpty) {
//           for (var def in meaning.definitions!) {
//             partOfSpeechList.add(PartOfSpeech(
//               name: meaning.partOfSpeech,
//               definition: def.definition,
//               example: def.example,
//             ));
            
//             // Nếu chỉ muốn lấy definition đầu tiên, dùng break ở đây
//             // break;
//           }
//         }
//       }

//       wordDetails.parts = partOfSpeechList.isNotEmpty ? partOfSpeechList : null;

//       return ResponseServices(
//         statusCode: 200, 
//         data: wordDetails, 
//         message: "Success"
//       );
//     } on FreeDictionaryException catch (e) {
//       return ResponseServices(
//         statusCode: 500,
//         data: null,
//         message: "Dictionary API error: ${e.message}"
//       );
//     } catch (e) {
//       return ResponseServices(
//         statusCode: 500,
//         data: null,
//         message: "Unexpected error: $e"
//       );
//     }
//   }
// }

// class Phonetic {
// }

// class WordDetails {
//   String? word;
//   String? phonetics;
//   String? audioUrl; // Thêm URL audio phát âm
//   List<PartOfSpeech>? parts;
  
//   WordDetails({this.word, this.phonetics, this.audioUrl, this.parts});
// }

// class PartOfSpeech {
//   String? name;
//   String? definition;
//   String? example;
  
//   PartOfSpeech({this.name, this.definition, this.example});
// }