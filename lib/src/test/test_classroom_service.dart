import 'package:flutter/material.dart';
import 'package:lingo_master/core/data/NativeService/class_service.dart';
import 'dart:convert';

import '../../core/domain/dtos/classroom/create_classroom_dto.dart';
import '../../core/domain/dtos/classroom/update_classroom.dart';

class SimpleApiTestClassroomServicePage extends StatefulWidget {
  @override
  _SimpleApiTestClassroomServicePage createState() =>
      _SimpleApiTestClassroomServicePage();
}

class _SimpleApiTestClassroomServicePage
    extends State<SimpleApiTestClassroomServicePage> {
  String _result1 = '';
  String _result2 = '';
  String _resultStatus = '';
  final classroomService = ClassRoomService();

  final String urlApi = "http://bao10022004-001-site1.qtempurl.com";
  final String sessionToken = 'your_token_here';

  Future<void> createClassRoomAsync() async {
    setState(() {
      _result2 = 'Đang gọi API tạo phòng học...';
    });

    try {
      final createDto = CreateClassRoomDto(
        name: 'Phòng học mới',
        classCode: 'PH001',
        description: 'Mô tả phòng học mới',
        isPublic: true,
      );

      final response = await classroomService.createClassRoom(createDto);

      if (response.success) {
        setState(() {
          _result2 = 'Tạo thành công, ID: ${response.data ?? ''}';
        });
      } else {
        setState(() {
          _result1 = 'Lỗi HTTP tạo phòng học: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result1 = 'Lỗi ngoại lệ tạo phòng học: $e';
      });
    }
  }

  Future<void> getClassRoomByIdAsync(String classRoomId) async {
    setState(() {
      _result2 = 'Đang tải thông tin phòng học...';
    });

    try {
      final response = await classroomService.getClassRoomById(classRoomId);

      if (response.success) {
        setState(() {
          final room = response.data;
          _result2 = 'Tên phòng: ${room?.name ?? ''}\nMã lớp: ${room?.classCode ?? ''}';
        });
      } else {
        setState(() {
          _result1 = 'Lỗi HTTP tải phòng học: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result1 = 'Lỗi ngoại lệ tải phòng học: $e';
      });
    }
  }

  Future<void> getAllClassRoomsAsync({bool includeDeleted = false}) async {
    setState(() {
      _result2 = 'Đang tải danh sách phòng học...';
    });

    try {
      final response = await classroomService.getAllClassRooms(includeDeleted: includeDeleted);

      if (response.success) {
        setState(() {
          final rooms = response.data ?? [];
          _result2 = 'Tải thành công ${rooms.length} phòng học:\n' +
              rooms.map((r) => '${r.name} (${r.classCode})').join('\n');
        });
      } else {
        setState(() {
          _result1 = 'Lỗi HTTP tải danh sách phòng học: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result1 = 'Lỗi ngoại lệ tải danh sách phòng học: $e';
      });
    }
  }

  Future<void> updateClassRoomAsync() async {
    setState(() {
      _result2 = 'Đang gọi API cập nhật phòng học...';
    });

    try {
      final updateDto = UpdateClassRoomDto(
        id: 'room-guid-cần-cập-nhật',
        name: 'Tên mới phòng học',
        description: 'Mô tả mới',
        isPublic: true,
      );

      final response = await classroomService.updateClassRoom(updateDto);

      if (response.success) {
        setState(() {
          _result2 = 'Cập nhật thành công: ${response.data ?? ''}';
        });
      } else {
        setState(() {
          _result1 = 'Lỗi cập nhật: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result1 = 'Lỗi ngoại lệ: $e';
      });
    }
  }

  Future<void> deleteClassRoomAsync(String classRoomId) async {
    setState(() {
      _result2 = 'Đang gọi API xóa phòng học...';
    });

    try {
      final response = await classroomService.deleteClassRoom(classRoomId);

      if (response.success) {
        setState(() {
          _result2 = 'Xóa phòng học thành công, ID: $classRoomId';
        });
      } else {
        setState(() {
          _result1 = 'Lỗi xóa phòng học: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result1 = 'Lỗi ngoại lệ: $e';
      });
    }
  }

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
                onPressed: createClassRoomAsync,
                child: Text('Gọi createClassRoomAsync API'),
              ), // GetById
              SizedBox(height: 20),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Text(
              //       _formatJson(_result2),
              //       style: TextStyle(fontFamily: 'Courier', fontSize: 14),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
