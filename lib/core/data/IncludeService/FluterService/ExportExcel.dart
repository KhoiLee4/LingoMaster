import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
class ExcelExport {
  static Future<String> ExportExcel(List<dynamic> danhSach, String nameFile) async {
    var excel = Excel.createExcel();
  
  Sheet sheet = excel['DanhSach'];
  
  Set<String> allKeys = {};
  
  for (var item in danhSach) {
    if (item is Map) {
      allKeys.addAll(item.keys.map((key) => key.toString()));
    }
  }
  
  List<String> sortedKeys = allKeys.toList()..sort();
  
  if (sortedKeys.isNotEmpty) {
    for (int i = 0; i < sortedKeys.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = sortedKeys[i];
    }
    
    for (int rowIndex = 0; rowIndex < danhSach.length; rowIndex++) {
      var item = danhSach[rowIndex];
      
      if (item is Map) {
        for (int colIndex = 0; colIndex < sortedKeys.length; colIndex++) {
          var value = item[sortedKeys[colIndex]];
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: colIndex, rowIndex: rowIndex + 1)).value = value;
        }
      } else {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex + 1)).value = item.toString();
      }
    }
  } else {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value = "Giá trị";
    
    for (int i = 0; i < danhSach.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1)).value = danhSach[i].toString();
    }
  }
  
  var fileBytes = excel.encode();
  
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  String appDocumentsPath = appDocumentsDirectory.path;
  String filePath = '$appDocumentsPath/'+nameFile+'.xlsx';
  
  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);
    
  return filePath;
  }
}
