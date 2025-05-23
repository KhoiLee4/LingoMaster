import 'package:flutter/material.dart';
import 'package:lingo_master/core/data/NativeService/folder_service.dart';
import 'package:lingo_master/core/data/NativeService/folder_user_service.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';
import 'package:lingo_master/core/domain/dtos/Folder/create_folder_dto.dart';
import 'package:lingo_master/core/domain/models/session.dart';

import '../../../../../../core/domain/dtos/folder_user/assign_folder_user_request.dart';

class AddThuMucScreen extends StatefulWidget {
  @override
  _AddThuMucScreenState createState() => _AddThuMucScreenState();
}

class _AddThuMucScreenState extends State<AddThuMucScreen> {
  final _titleController = TextEditingController();
  final _folderService = new FolderService();
  final _folderUserService = new FolderUserService();
  late CreateFolderDto _createFolderDTO;
  late AssignFolderUserRequest _assignFolderUserRequest;
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
          'Thư mục mới',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _createThuMuc,
            child: Text(
              'Tạo thư mục',
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Input
            _buildInputField(
              'Tiêu đề',
              _titleController,
              'Nhập tên thư mục',
            ),
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

  void _createThuMuc() async{
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập tên thư mục'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Thực hiện logic tạo thư mục ở đây
    _createFolderDTO = new CreateFolderDto(name: _titleController.text);

    var respone = await _folderService.createFolderAsync(_createFolderDTO);
    if (respone != null) {
      _assignFolderUserRequest = new AssignFolderUserRequest(userId: Session.user!.Id!, folderId: respone.data!.id!);
      _folderUserService.assignFolderToUserAsync(_assignFolderUserRequest);
    }


    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã tạo thư mục "${_titleController.text}" thành công!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
