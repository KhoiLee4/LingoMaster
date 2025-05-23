import 'package:flutter/material.dart';
import 'package:lingo_master/core/data/NativeService/class_service.dart';
import 'package:lingo_master/core/data/NativeService/class_user_service.dart';
import 'package:lingo_master/core/domain/models/session.dart';

import '../../../../../../core/domain/dtos/classroom/create_classroom_dto.dart';
import '../../../../../../core/domain/dtos/classroom_set/assign_class_room_user_dto.dart';

class AddLopHocScreen extends StatefulWidget {
  const AddLopHocScreen({super.key});

  @override
  _AddLopHocScreenState createState() => _AddLopHocScreenState();
}

class _AddLopHocScreenState extends State<AddLopHocScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _allowStudentInvite = true;
  final _classService = new ClassRoomService();
  late CreateClassRoomDto _createClassRoomDto;
  final _classUserService = new ClassRoomUserService();
  late AssignClassRoomUserDto _assignClassRoomUserDto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Lớp mới',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.blue),
            onPressed: _createLopHoc,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Class Name Input
            _buildInputField(
              'Tên lớp',
              _titleController,
              'Nhập tên lớp học',
            ),

            SizedBox(height: 20),

            // Description Input
            _buildInputField(
              'Mô tả',
              _descriptionController,
              'Thêm mô tả cho lớp học',
              maxLines: 3,
            ),

            SizedBox(height: 30),

            // Student Invite Permission
            _buildPermissionToggle(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label,
      TextEditingController controller,
      String hint, {
        int maxLines = 1,
      }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionToggle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cho phép thành viên lớp thêm học phần và thành viên mới',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Switch(
            value: _allowStudentInvite,
            onChanged: (value) {
              setState(() {
                _allowStudentInvite = value;
              });
            },
            activeColor: Colors.white,
            activeTrackColor: Colors.blue,
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  void _createLopHoc() async{
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập tên lớp học'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _createClassRoomDto = new CreateClassRoomDto(name: _titleController.text, description: _descriptionController.text, isPublic: _allowStudentInvite);
    var response = await _classService.createClassRoom(_createClassRoomDto);
    if (response != null){
      _assignClassRoomUserDto = new AssignClassRoomUserDto(userId: Session.user!.Id!, classRoomId: response.data!.id!);
      _classUserService.assignUserToClassRoom(_assignClassRoomUserDto);
    }
    // Thực hiện logic tạo lớp học ở đây
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã tạo lớp học "${_titleController.text}" thành công!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}