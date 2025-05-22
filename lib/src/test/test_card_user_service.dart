import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lingo_master/core/domain/dtos/Card/card_dto.dart';
import 'package:lingo_master/core/domain/dtos/Card/update_card_dto.dart';

import '../../core/data/NativeService/card_service.dart';
import '../../core/data/NativeService/card_user_service.dart';
import '../../core/domain/dtos/Card/create_card_dto.dart';
import '../../core/domain/dtos/card_user/assignCardRequest.dart';
import '../../core/domain/dtos/card_user/card_user_status_dto.dart';
import '../../core/domain/dtos/card_user/update_card_status_request.dart';

class SimpleApiTestUserServicePage extends StatefulWidget {
  @override
  _SimpleApiTestUserServicePage createState() =>
      _SimpleApiTestUserServicePage();
}

class _SimpleApiTestUserServicePage
    extends State<SimpleApiTestUserServicePage> {
  String _result = '';
  String _result1 = '';
  String _result2 = '';
  String _result3 = '';
  String _resultStatus = '';
  final cardUserService = CardUserService();

  final String urlApi = "http://bao10022004-001-site1.qtempurl.com";
  final String sessionToken = 'your_token_here';

  Future<void> assignCardToUserAsync() async {
    setState(() {
      _result2 = 'Đang gọi API gán Card cho User...';
    });

    try {
      final request = AssignCardRequest(
        userId: "F4A8B27C-A782-434C-D9D0-08DD967C562B",
        cardId: "9540A861-521D-43BD-9FFC-08DD98809D39",
      );

      final response = await cardUserService.assignCardToUser(request);

      if (response.success) {
        setState(() {
          _result2 = 'Gán card thành công: ${response.data ?? ''}';
        });
      } else {
        setState(() {
          _result2 = 'Lỗi khi gán card: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result2 = 'Lỗi ngoại lệ: $e';
      });
    }
  }

  Future<void> updateCardUserStatusAsync() async {
    setState(() {
      _result2 = 'Đang gọi API cập nhật trạng thái...';
    });

    try {
      final request = UpdateCardStatusRequest(
        userId: 'user-guid-here',
        cardId: 'card-guid-here',
        status: CardUserStatusDto(
          isFavorite: true,
          isKnow: false,
          isChecked: true,
          isLearned: false,
        ),
      );

      final response = await cardUserService.updateCardUserStatus(request);

      if (response.success) {
        setState(() {
          _result2 = 'Cập nhật trạng thái thành công: ${response.data ?? ''}';
        });
      } else {
        setState(() {
          _result2 = 'Lỗi cập nhật trạng thái: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result2 = 'Lỗi ngoại lệ: $e';
      });
    }
  }

  Future<void> getCardsForUserAsync() async {
    setState(() {
      _result3 = 'Đang tải danh sách cards...';
    });
    String userId = "F4A8B27C-A782-434C-D9D0-08DD967C562B";
    try {
      final response = await cardUserService.getCardsForUser(userId);

      if (response.success) {
        setState(() {
          final cards = response.data ?? [];
          _result3 = 'Tải thành công ${cards.length} cards:\n' +
              cards.map((c) => '${c.key}: ${c.value}').join('\n');
        });
      } else {
        setState(() {
          _result3 = 'Lỗi tải cards: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result3 = 'Lỗi ngoại lệ: $e';
      });
    }
  }

  Future<void> getCardStatusAsync() async {
    setState(() {
      _resultStatus = 'Đang tải trạng thái card...';
    });
    String userId = "F4A8B27C-A782-434C-D9D0-08DD967C562B";
    String cardId = "E764379A-E486-4B5C-7DF0-08DD97640B06";
    try {
      final response = await cardUserService.getCardStatus(userId, cardId);

      if (response.success) {
        setState(() {
          final status = response.data;
          if (status != null) {
            _resultStatus = 'Trạng thái Card:\n'
                'Favorite: ${status.isFavorite}\n'
                'Know: ${status.isKnow}\n'
                'Checked: ${status.isChecked}\n'
                'Learned: ${status.isLearned}';
          } else {
            _resultStatus = 'Không có dữ liệu trạng thái.';
          }
        });
      } else {
        setState(() {
          _resultStatus = 'Lỗi tải trạng thái: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _resultStatus = 'Lỗi ngoại lệ: $e';
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
                onPressed: assignCardToUserAsync,
                child: Text('Gọi assignCardToUserAsync API'),
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
            ],
          ),
        ));
  }
}
