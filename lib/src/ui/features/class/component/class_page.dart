import 'package:flutter/material.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String className = "kkkk";  // Changed from "tết" to "kkkk"
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

  void _showMenu() {
    setState(() {
      isMenuOpen = true;
    });
  }

  void _hideMenu() {
    setState(() {
      isMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
          },
        ),
        title: const Text('Lớp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showMenu,
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
          if (isMenuOpen)
            Positioned(
              top: 0,
              right: 0,
              child: Stack(
                children: [
                  // Invisible overlay to detect tap outside menu
                  GestureDetector(
                    onTap: _hideMenu,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, right: 8),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildMenuItem('Mời thành viên', Icons.person_add),
                          _buildMenuItem('Thêm học phần', Icons.post_add),
                          _buildMenuItem('Thêm thư mục', Icons.create_new_folder),
                          _buildMenuItem('Báo cáo', Icons.flag),
                          _buildMenuItem('Bỏ lớp học', Icons.exit_to_app),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: '',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData? icon) {
    return InkWell(
      onTap: () {
        _hideMenu();
        // Handle menu item tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: Colors.transparent),
              const SizedBox(width: 16),
            ],
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Empty lessons content widget
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

  // Lessons content widget when there are lessons
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