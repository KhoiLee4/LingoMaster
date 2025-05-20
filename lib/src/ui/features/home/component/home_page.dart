import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _showNotifications = false;

  // Controllers for PageView
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // App bar section with search and notification
              _buildAppBar(),

              // Main content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    _buildHomeContent(),
                    const Center(child: Text('Lời giải', style: TextStyle(color: Colors.white))),
                    const Center(child: Text('Thêm', style: TextStyle(color: Colors.white))),
                    const Center(child: Text('Thư viện', style: TextStyle(color: Colors.white))),
                    const Center(child: Text('Hồ sơ', style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ],
          ),

          // Notifications overlay
          if (_showNotifications)
            _buildNotificationsOverlay(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            // Show bottom sheet when + button is pressed
            _showAddBottomSheet(context);
          } else {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          }
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: 'Lời giải',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Hồ sơ',
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Quizlet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    'Dùng thử miễn phí',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _showNotifications = !_showNotifications;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Học phần, sách giáo khoa, câu hỏi',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Main content sections with horizontal scrolling categories
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        margin: const EdgeInsets.only(top: 16),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thu muc section
              _buildSection('Thư mục', [
                _buildFolderItem('test', 'KhoiLee04', true),
              ]),

              const SizedBox(height: 20),

              // Thanh tuu section with calendar
              _buildAchievementSection(),

              const SizedBox(height: 20),

              // Lop hoc section
              _buildSection('Lớp học', [
                _buildClassItem('tét', '0 học phần', '1 thành viên'),
              ]),

              const SizedBox(height: 20),

              // Duyet theo chu de section
              _buildCategoriesSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Section builder with title and horizontal scrollable content
  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: title == 'Thư mục' ? 120 : 100,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            children: items,
          ),
        ),
      ],
    );
  }

  // Folder item in horizontal list
  Widget _buildFolderItem(String name, String author, bool hasIcon) {
    return Container(
      width: 220,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (hasIcon) const Icon(Icons.folder, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 16, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  author,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Class item in horizontal list
  Widget _buildClassItem(String name, String lessons, String members) {
    return Container(
      width: 220,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.book_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  lessons,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.people_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  members,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Achievement section with calendar
  Widget _buildAchievementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Thành tựu',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              // Achievement message
              const Text(
                'Hiện chưa có chuỗi nào',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Calendar icon
              const Icon(
                Icons.calendar_today,
                size: 50,
                color: Colors.grey,
              ),
              const SizedBox(height: 24),
              // Encouragement message
              const Text(
                'Hãy học để bắt đầu chuỗi mới của bạn!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Week calendar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCalendarDay('S', '13'),
                  _buildCalendarDay('M', '14'),
                  _buildCalendarDay('T', '15', isActive: true),
                  _buildCalendarDay('W', '16'),
                  _buildCalendarDay('T', '17'),
                  _buildCalendarDay('F', '18'),
                  _buildCalendarDay('S', '19'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Calendar day item
  Widget _buildCalendarDay(String day, String date, {bool isActive = false}) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isActive)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  // Categories section
  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Duyệt theo chủ đề',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _buildCategoryItem('Ngôn ngữ', Colors.purple, Icons.translate),
              _buildCategoryItem('Khoa học', Colors.blue, Icons.science),
              _buildCategoryItem('Nghệ thuật', Colors.pink, Icons.brush),
              _buildCategoryItem('Toán học', Colors.amber, Icons.calculate),
              _buildCategoryItem('Khoa học xã hội', Colors.teal, Icons.public),
            ],
          ),
        ),
      ],
    );
  }

  // Category item
  Widget _buildCategoryItem(String name, Color color, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Notifications overlay
  Widget _buildNotificationsOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black54,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  setState(() {
                    _showNotifications = false;
                  });
                },
              ),
              title: const Text(
                'Hoạt động',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Icon(Icons.cake, color: Colors.white),
                      ),
                      title: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Thêm tuổi mới, thêm thông thái! ',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                            TextSpan(
                              text: 'Cùng học cách nói "chúc mừng sinh nhật" bằng một ngôn ngữ mới.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      subtitle: const Text('It'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show bottom sheet for add button
  void _showAddBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar for dragging
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        const SizedBox(height: 20),
                        // Study Sets Option
                        _buildAddOption(
                          icon: Icons.book,
                          iconColor: Colors.blue,
                          title: 'Học phần',
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to create study set
                          },
                        ),

                        // Folders Option
                        _buildAddOption(
                          icon: Icons.folder,
                          iconColor: Colors.indigo,
                          title: 'Thư mục',
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to create folder
                          },
                        ),

                        // Class Option
                        _buildAddOption(
                          icon: Icons.people,
                          iconColor: Colors.green,
                          title: 'Lớp',
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to create class
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Option item for add bottom sheet
  Widget _buildAddOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}