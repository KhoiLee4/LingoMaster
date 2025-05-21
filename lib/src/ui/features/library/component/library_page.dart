import 'package:flutter/material.dart';
import 'class/add_class_page.dart';
import 'course/add_course_page.dart';
import 'folder/add_folder_page.dart';
import 'class/class_tab.dart';
import 'course/course_tab.dart';
import 'folder/folder_tab.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  String _selectedFilter = 'Tất cả';
  bool _showFilterDropdown = false;

  final List<String> _filterOptions = [
    'Tất cả',
    'Đã tạo',
    'Đã học',
    'Đã tải về'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleAddNew() {
    Widget screen;
    String title;

    switch (_selectedTabIndex) {
      case 0: // Học phần
        screen = AddHocPhanScreen();
        title = 'Tạo học phần mới';
        break;
      case 1: // Thư mục
        screen = AddThuMucScreen();
        title = 'Tạo thư mục mới';
        break;
      case 2: // Lớp học
        screen = AddLopHocScreen();
        title = 'Tạo lớp học mới';
        break;
      default:
        return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Thư viện',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black54, size: 28),
            onPressed: _handleAddNew,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.blue,
              indicatorWeight: 3,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(text: 'Học phần'),
                Tab(text: 'Thư mục'),
                Tab(text: 'Lớp học'),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Section - chỉ hiển thị cho tab "Học phần"
          if (_selectedTabIndex == 0) _buildFilterSection(),

          // Content Section
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CourseTab(selectedFilter: _selectedFilter),
                FolderTab(),
                ClassTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      children: [
        // Filter Dropdown Button
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showFilterDropdown = !_showFilterDropdown;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedFilter,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        _showFilterDropdown
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Filter Options
        if (_showFilterDropdown)
          Container(
            color: Colors.white,
            child: Column(
              children: _filterOptions.map((option) {
                return ListTile(
                  title: Text(option),
                  trailing: _selectedFilter == option
                      ? Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedFilter = option;
                      _showFilterDropdown = false;
                    });
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Lời giải',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[400]!, width: 2),
              ),
              child: Icon(Icons.add, size: 20),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Hồ sơ',
          ),
        ],
        currentIndex: 3,
        // Thư viện tab is selected
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
