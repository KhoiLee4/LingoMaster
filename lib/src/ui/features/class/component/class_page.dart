import 'package:flutter/material.dart';

import '../../../../../core/design_systems/theme/app_colors.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String className = "kkkk";
  bool isMenuOpen = false;
  bool hasLessons = true;  // Set to true to show lessons instead of empty state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  void _hideMenu() {
    setState(() {
      isMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Lớp'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert), // biểu tượng 3 chấm
            onSelected: (value) {
              // Xử lý từng lựa chọn
              switch (value) {
                case 'invite':
                // Mời thành viên
                  print("Mời thành viên");
                  break;
                case 'add_course':
                  print("Thêm học phần");
                  break;
                case 'add_folder':
                  print("Thêm thư mục");
                  break;
                case 'report':
                  print("Báo cáo");
                  break;
                case 'leave_class':
                  print("Bỏ lớp học");
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'invite',
                child: Text('Mời thành viên'),
              ),
              PopupMenuItem(
                value: 'add_course',
                child: Text('Thêm học phần'),
              ),
              PopupMenuItem(
                value: 'add_folder',
                child: Text('Thêm thư mục'),
              ),
              PopupMenuItem(
                value: 'report',
                child: Text('Báo cáo'),
              ),
              PopupMenuItem(
                value: 'leave_class',
                child: Text('Bỏ lớp học'),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        hasLessons ? '1 học phần' : '0 học phần',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      className,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'HỌC PHẦN'),
                  Tab(text: 'THÀNH VIÊN'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // First tab content - Lessons section
                    hasLessons
                        ? _buildLessonsContent()
                        : _buildEmptyLessonsContent(),
                    // Second tab content - Members section
                    ListView(
                      children: [
                        // Just show one member for demonstration
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                            radius: 20,
                          ),
                          title: const Text('KhoiLee04'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Popup menu when 3-dot icon is clicked
        ],
      ),
    );
  }

  // Empty lessons content widgets
  Widget _buildEmptyLessonsContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Lớp học này không có học phần nào',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        const Text(
          'Thêm học phần để chia sẻ với lớp của bạn.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            // Handle add lesson
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text(
            'Thêm học phần',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // Lessons content widgets when there are lessons
  Widget _buildLessonsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'ÍT GIÂY TRƯỚC',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Meetings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '7 thuật ngữ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                        radius: 16,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'KNgao1',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}