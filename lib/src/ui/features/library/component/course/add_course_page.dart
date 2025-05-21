import 'package:flutter/material.dart';

// screens/add_hoc_phan_screen.dart
import 'package:flutter/material.dart';

class AddHocPhanScreen extends StatefulWidget {
  @override
  _CreateHocPhanScreenState createState() => _CreateHocPhanScreenState();
}

class _CreateHocPhanScreenState extends State<AddHocPhanScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tạo học phần',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.grey[700]),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.check, color: Colors.grey[700]),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field for subject, chapter, unit
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Chủ đề, chương, đơn vị',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                ),
              ),
            ),

            // Blue divider
            Container(
              height: 3,
              color: Colors.blue[700],
            ),

            // TIÊU ĐỀ label
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 24, bottom: 16),
              child: Text(
                'TIÊU ĐỀ',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),

            // Quét tài liệu row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.qr_code_scanner, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    'Quét tài liệu',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.lock, color: Colors.white, size: 16),
                  ),
                  Spacer(),
                  Text(
                    '+ Mô tả',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // White card 1
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  SizedBox(height: 16),
                  Text(
                    'THUẬT NGỮ',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 32),
                  Divider(),
                  SizedBox(height: 16),
                  Text(
                    'ĐỊNH NGHĨA',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),

            // White card 2
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  SizedBox(height: 16),
                  Text(
                    'THUẬT NGỮ',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 32),
                  Divider(),
                  SizedBox(height: 16),
                  Text(
                    'ĐỊNH NGHĨA',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.crop_square),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoSaveEnabled = true;
  String _visibilityOption = 'Mọi người';
  String _editOption = 'Chỉ tôi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Cài đặt tùy chọn',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              'NGÔN NGỮ',
              style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),

          // Language settings
          Container(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: Text('Thuật ngữ'),
                  trailing: Text(
                    'Chọn ngôn ngữ',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Divider(height: 1, indent: 16, endIndent: 16),
                ListTile(
                  title: Text('Định nghĩa'),
                  trailing: Text(
                    'Chọn ngôn ngữ',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),

          // Auto-save setting
          Container(
            margin: EdgeInsets.only(top: 16),
            color: Colors.white,
            child: ListTile(
              title: Text('Gợi ý tự động'),
              trailing: Switch(
                value: _autoSaveEnabled,
                onChanged: (value) {
                  setState(() {
                    _autoSaveEnabled = value;
                  });
                },
                activeColor: Colors.blue,
              ),
            ),
          ),

          // Privacy section
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 24, bottom: 8),
            child: Text(
              'QUYỀN RIÊNG TƯ',
              style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),

          // Visibility settings
          Container(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: Text('Ai có thể xem'),
                  trailing: Text(
                    _visibilityOption,
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    setState(() {
                      _visibilityOption = _visibilityOption == 'Mọi người'
                          ? 'Chỉ tôi'
                          : 'Mọi người';
                    });
                  },
                ),
                Divider(height: 1, indent: 16, endIndent: 16),
                ListTile(
                  title: Text('Ai có thể sửa'),
                  trailing: Text(
                    _editOption,
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    setState(() {
                      _editOption = _editOption == 'Chỉ tôi'
                          ? 'Mọi người'
                          : 'Chỉ tôi';
                    });
                  },
                ),
              ],
            ),
          ),

          // Delete button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Text(
              'Xóa học phần',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.crop_square),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}