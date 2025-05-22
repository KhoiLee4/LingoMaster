import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lingo_master/core/domain/dtos/Card/card_dto.dart';
import 'package:lingo_master/core/domain/dtos/Card/update_card_dto.dart';

import '../../core/data/NativeService/card_service.dart';
import '../../core/domain/dtos/Card/create_card_dto.dart';

class SimpleApiTestPage extends StatefulWidget {
  @override
  _SimpleApiTestPageState createState() => _SimpleApiTestPageState();
}

class _SimpleApiTestPageState extends State<SimpleApiTestPage> {
  String _result = '';
  String _result1 = '';
  String _result2 = '';
  String _result3 = '';
  String _result4 = '';
  final cardService = CardService();

  final String urlApi = "http://bao10022004-001-site1.qtempurl.com";
  final String sessionToken = 'your_token_here';

  Future<void> getCardById() async {
    const cardId = 'E764379A-E486-4B5C-7DF0-08DD97640B06'; // Mã card ví dụ

    setState(() {
      _result = 'Đang gọi API...';
    });

    try {
      final response = await cardService.getCardById(cardId);

      if (response.success) {
        setState(() {
          _result = response.data!.id;
        });
      } else {
        setState(() {
          _result = 'Lỗi HTTP: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Lỗi: $e';
      });
    }
  }

  Future<void> GetAllCardsAsync() async {
    setState(() {
      _result = 'Đang gọi API...';
    });

    try {
      final response = await cardService.getAllCardsAsync();

      if (response.success) {
        setState(() {
          List<CardDto>? list = response.data;
          String temp = '';
          if (list != null) {
            for (int i = 0; i < list.length; i++) {
              temp += list[i].id;
              temp += "\n";
            }
          }
          setState(() {
            _result1 = temp;
          });
        });
      } else {
        setState(() {
          _result1 = 'Lỗi HTTP: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result1 = 'Lỗi: $e';
      });
    }
  }

  Future<void> AddCardsAsync() async {
    setState(() {
      _result2 = 'Đang gọi API...';
    });

    try {
      final createCardDto = CreateCardDto(
        key: "buy",
        value: 'Mua',
        idSet: '15e8c7a0-103b-47f7-6559-08dd975190c2',
        image: null,
      );
      final response = await cardService.createCard(createCardDto);

      if (response.success) {
        setState(() {
          _result2 = response.data!.id;
        });
      } else {
        setState(() {
          _result1 = 'Lỗi HTTP: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result1 = 'Lỗi: $e';
      });
    }
  }
  Future<void> updateCardAsync() async {
    setState(() {
      _result2 = 'Đang gọi API cập nhật...';
    });

    try {
      final updateCardDto = UpdateCardDto(
        id: 'e764379a-e486-4b5c-7df0-08dd97640b06',   // ID của card bạn muốn cập nhật
        key: "go",
        value: 'Updated Value',
        idSet: '15e8c7a0-103b-47f7-6559-08dd975190c2',
        image: null
      );

      final response = await cardService.updateCard(updateCardDto);

      if (response.success) {
        setState(() {
          _result2 = 'Cập nhật thành công, ID: ${response.data?.id ?? 'null'}';
        });
      } else {
        setState(() {
          _result2 = 'Lỗi cập nhật: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result2 = 'Lỗi ngoại lệ: $e';
      });
    }
  }


  Future<void> deleteCardAsync() async {
    setState(() {
      _result3 = 'Đang gọi API xóa...';
    });
    String cardId = "4F5F2C72-B244-4201-1319-08DD99058649";
    try {
      final response = await cardService.deleteCard(cardId);

      if (response.success) {
        setState(() {
          _result3 = 'Xóa thành công card ID: $cardId';
        });
      } else {
        setState(() {
          _result3 = 'Lỗi khi xóa: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result3 = 'Lỗi ngoại lệ: $e';
      });
    }
  }





// Hàm helper format JSON string
  String _formatJson(String jsonString) {
    try {
      final jsonObject = jsonDecode(jsonString);
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(jsonObject);
    } catch (e) {
      // Nếu không parse được thì trả lại nguyên bản
      return jsonString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Simple API Card Test')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              ElevatedButton(
                onPressed: getCardById,
                child: Text('Gọi GetCardById API'),
              ), // GetById
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _formatJson(_result),
                    style: TextStyle(fontFamily: 'Courier', fontSize: 14),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: GetAllCardsAsync,
                child: Text('Gọi GetAllCards API'),
              ), // GetAll
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _formatJson(_result1),
                    style: TextStyle(fontFamily: 'Courier', fontSize: 14),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: AddCardsAsync,
                child: Text('Gọi AddCard API'),
              ), // Created
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _formatJson(_result2),
                    style: TextStyle(fontFamily: 'Courier', fontSize: 14),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: updateCardAsync,
                child: Text('Gọi UpdateCard API'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _formatJson(_result3),
                    style: TextStyle(fontFamily: 'Courier', fontSize: 14),
                  ),
                ),
              ),
              ElevatedButton( // Delete
                onPressed: deleteCardAsync,
                child: Text('Gọi DeleteCard API'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _formatJson(_result4),
                    style: TextStyle(fontFamily: 'Courier', fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
