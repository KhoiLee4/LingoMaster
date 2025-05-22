import 'package:flutter/material.dart';
import 'package:lingo_master/core/data/NativeService/class_service.dart';
import 'package:lingo_master/core/data/NativeService/class_set_service.dart';
import 'dart:convert';

import '../../core/data/NativeService/class_set_service.dart';
import '../../core/domain/dtos/classroom/create_classroom_dto.dart';
import '../../core/domain/dtos/classroom/update_classroom.dart';
import '../../core/domain/dtos/classroom_set/classroom_set_dto.dart';

class SimpleApiTestClassroomServicePage extends StatefulWidget {
  @override
  _SimpleApiTestClassroomServicePage createState() =>
      _SimpleApiTestClassroomServicePage();
}

class _SimpleApiTestClassroomServicePage
    extends State<SimpleApiTestClassroomServicePage> {
  String _result1 = '';
  String _result2 = '';
  String _resultSets = '';
  final classroomSetService = ClassroomSetService();

  final String urlApi = "http://bao10022004-001-site1.qtempurl.com";
  final String sessionToken = 'your_token_here';

  Future<void> assignSetToClassroomAsync() async {
    setState(() {
      _result2 = 'Đang gọi API gán Set cho Classroom...';
    });

    try {
      final request = ClassroomSetDto(
        classroomId: 'classroom-guid-here',
        setId: 'set-guid-here',
      );

      final response = await classroomSetService.assignSetToClassroom(request);

      if (response.success) {
        setState(() {
          _result2 = 'Gán Set cho Classroom thành công.';
        });
      } else {
        setState(() {
          _result2 = 'Lỗi khi gán: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _result2 = 'Lỗi ngoại lệ: $e';
      });
    }
  }
  Future<void> getSetsForClassroomAsync(String classroomId) async {
    setState(() {
      _resultSets = 'Đang tải danh sách Sets cho phòng học...';
    });

    try {
      final response = await classroomSetService.getSetsForClassroom(classroomId);

      if (response.success) {
        setState(() {
          final sets = response.data ?? [];
          _resultSets = 'Tải thành công ${sets.length} sets:\n' +
              sets.map((s) => 'ClassroomId: ${s.classroomId}, SetId: ${s.setId}').join('\n');
        });
      } else {
        setState(() {
          _resultSets = 'Lỗi tải sets: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _resultSets = 'Lỗi ngoại lệ: $e';
      });
    }
  }
  Future<void> getAllSetByClassroomIdAsync(String classroomId) async {
    setState(() {
      _resultSets = 'Đang tải danh sách sets cho phòng học...';
    });

    try {
      final response = await classroomSetService.getAllSetByClassroomId(classroomId);

      if (response.success) {
        setState(() {
          final sets = response.data ?? [];
          _resultSets = 'Tải thành công ${sets.length} sets:\n' +
              sets.map((s) => '${s.nameSet} - ${s.nameUser} (Cards: ${s.totalCard})').join('\n');
        });
      } else {
        setState(() {
          _resultSets = 'Lỗi tải sets: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _resultSets = 'Lỗi ngoại lệ: $e';
      });
    }
  }
  Future<void> getClassroomsForSetAsync(String setId) async {
    setState(() {
      _resultSets = 'Đang tải danh sách phòng học theo Set...';
    });

    try {
      final response = await classroomSetService.getClassroomsForSet(setId);

      if (response.success) {
        setState(() {
          final classrooms = response.data ?? [];
          _resultSets = 'Tải thành công ${classrooms.length} phòng học:\n' +
              classrooms.map((c) => 'ClassroomId: ${c.classroomId}, SetId: ${c.setId}').join('\n');
        });
      } else {
        setState(() {
          _resultSets = 'Lỗi tải phòng học: ${response.message}';
        });
      }
    } catch (e) {
      setState(() {
        _resultSets = 'Lỗi ngoại lệ: $e';
      });
    }
  }
 // thiếu 1 hàm
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
                onPressed: assignSetToClassroomAsync,
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
