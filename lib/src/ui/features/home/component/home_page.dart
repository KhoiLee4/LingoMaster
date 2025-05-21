import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';
import 'package:lingo_master/widgets/class_item.dart';
import 'package:lingo_master/widgets/folder_item.dart';
import 'package:lingo_master/widgets/course_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // AppBar dạng cong
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              height: 225,
              color: AppColors.primaryBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'LingoMater',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                        ),
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
          ),
          // Nội dung phía dưới
          // if (_showNotifications) _buildNotificationsOverlay(),
          // _buildNotificationsOverlay(),
          Expanded(
            child: _buildHomeContent(),
          ),
        ],
      ),
    );
  }

  // Main content sections with horizontal scrolling categories
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(30),
          //   topRight: Radius.circular(30),
          // ),
        ),
        // margin: const EdgeInsets.only(top: 16),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thu muc section
              _buildSection('Thư mục', [
                FolderItem(
                  name: 'KKKK',
                  author: 'KhoiLee04',
                ),
                FolderItem(
                  name: 'KKKK',
                  author: 'KhoiLee04',
                ),
                FolderItem(
                  name: 'KKKK',
                  author: 'KhoiLee04',
                ),
                FolderItem(
                  name: 'KKKK',
                  author: 'KhoiLee04',
                ),
              ]),

              const SizedBox(height: 20),

              // Thanh tuu section with calendar
              _buildAchievementSection(),

              const SizedBox(height: 20),

              // Thu muc section
              _buildSection('Học phần', [
                CourseItem(name: 'test', count: 95, author: 'KhoiLee04'),
                CourseItem(name: 'test', count: 95, author: 'KhoiLee04'),
                CourseItem(name: 'test', count: 95, author: 'KhoiLee04'),
                CourseItem(name: 'test', count: 95, author: 'KhoiLee04'),
              ]),

              const SizedBox(height: 20),

              // Lop hoc section
              _buildSection('Lớp học', [
                ClassItem(
                  name: 'tét',
                  lessons: '0 học phần',
                  members: '1 thành viên',
                ),
                ClassItem(
                  name: 'tét',
                  lessons: '0 học phần',
                  members: '1 thành viên',
                ),
                ClassItem(
                  name: 'tét',
                  lessons: '0 học phần',
                  members: '1 thành viên',
                ),
                ClassItem(
                  name: 'tét',
                  lessons: '0 học phần',
                  members: '1 thành viên',
                ),
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
          height: title == 'Lớp học' ? 110 : 140,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            children: items,
          ),
        ),
      ],
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
        // const SizedBox(height: 12),
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
                              text:
                                  'Cùng học cách nói "chúc mừng sinh nhật" bằng một ngôn ngữ mới.',
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
}

// Tạo phần cong dưới AppBar
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 35); // Đi tới gần đáy
    path.quadraticBezierTo(
      size.width / 2, size.height, // điểm cong giữa
      size.width, size.height - 35, // điểm kết thúc
    );
    path.lineTo(size.width, 0); // Đi lên lại
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
