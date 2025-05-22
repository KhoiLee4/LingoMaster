import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../core/data/NativeService/folder_service.dart';
import '../../../../../core/design_systems/theme/app_colors.dart';
import '../../../../../core/domain/dtos/class_dto.dart';
import '../../../../../core/domain/dtos/set/set_dto.dart';
import '../../../../../widgets/class_item.dart';
import '../../../../../widgets/course_item.dart';
import '../../../../../widgets/folder_item.dart';
import '../bloc/folder/folder_bloc.dart';
import '../bloc/folder/folder_event.dart';
import '../bloc/folder/folder_state.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FolderBloc>(
      create: (context) {
        final bloc = FolderBloc(FolderService());
        // Trigger loading folders immediately after creating the bloc
        bloc.add(LoadFolders());
        return bloc;
      },
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showNotifications = false;

  @override
  void initState() {
    super.initState();
    // No need to trigger LoadFolders here anymore since it's done in HomeProvider
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Custom AppBar with curved bottom
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
              // Main content
              const Expanded(
                child: HomeContent(),
              ),
            ],
          ),
          // Notifications overlay
          if (_showNotifications) NotificationsOverlay(
            onClose: () {
              setState(() {
                _showNotifications = false;
              });
            },
          ),
        ],
      ),
    );
  }
}

// Custom clipper for curved AppBar bottom
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 35);
    path.quadraticBezierTo(
      size.width / 2, size.height,
      size.width, size.height - 35,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Notifications overlay widget
class NotificationsOverlay extends StatelessWidget {
  final VoidCallback onClose;

  const NotificationsOverlay({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
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
                onPressed: onClose,
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
}

// Main content widget
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Folders section
              FolderSection(),
              SizedBox(height: 20),

              // Achievement section
              AchievementSection(),
              SizedBox(height: 20),

              // Courses section
              CoursesSection(),
              SizedBox(height: 20),

              // Classes section
              ClassesSection(),
              SizedBox(height: 20),

              // Categories section
              CategoriesSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// Folder section widget
class FolderSection extends StatelessWidget {
  const FolderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Thư mục'),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: const FolderListSection(),
        ),
      ],
    );
  }
}

// Folder list with BLoC integration - FIXED VERSION
class FolderListSection extends StatelessWidget {
  const FolderListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderBloc, FolderState>(
      builder: (context, state) {
        if (state is FolderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FolderLoaded) {

          if (state.folders == null) {
            return const Center(
              child: Text(
                'Chưa có thư mục nào',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: state.folders?.length,
            itemBuilder: (context, index) {
              return FolderItem(item: state.folders![index]);
            },
          );
        } else if (state is FolderError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lỗi: ${state.message}"),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<FolderBloc>().add(LoadFolders());
                  },
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          );
        } else {
          // Initial state - trigger loading if not already loaded
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.read<FolderBloc>().add(LoadFolders());
            }
          });

          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// Achievement section widget
class AchievementSection extends StatelessWidget {
  const AchievementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Thành tựu'),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Column(
            children: [
              Text(
                'Hiện chưa có chuỗi nào',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Icon(
                Icons.calendar_today,
                size: 50,
                color: Colors.grey,
              ),
              SizedBox(height: 24),
              Text(
                'Hãy học để bắt đầu chuỗi mới của bạn!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              WeekCalendar(),
            ],
          ),
        ),
      ],
    );
  }
}

// Week calendar widget
class WeekCalendar extends StatelessWidget {
  const WeekCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CalendarDay(day: 'S', date: '13'),
        CalendarDay(day: 'M', date: '14'),
        CalendarDay(day: 'T', date: '15', isActive: true),
        CalendarDay(day: 'W', date: '16'),
        CalendarDay(day: 'T', date: '17'),
        CalendarDay(day: 'F', date: '18'),
        CalendarDay(day: 'S', date: '19'),
      ],
    );
  }
}

// Calendar day widget
class CalendarDay extends StatelessWidget {
  final String day;
  final String date;
  final bool isActive;

  const CalendarDay({
    super.key,
    required this.day,
    required this.date,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
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
}

// Courses section widget
class CoursesSection extends StatelessWidget {
  const CoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleCourses = List.generate(4, (index) =>
        CourseItem(
          item: SetDto(
            name: 'ETS RC2 test ${index + 1}',
            id: 'course_$index',
            createAt: DateTime.now(),
            updateAt: DateTime.now(),
            idTopic: 'topic_$index',
          ),
        ),
    );

    return HorizontalScrollSection(
      title: 'Học phần',
      items: sampleCourses,
      height: 150,
    );
  }
}

// Classes section widget
class ClassesSection extends StatelessWidget {
  const ClassesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleClasses = List.generate(4, (index) =>
        ClassItem(
          item: ClassRoomDto(
            className: 'Lớp học ${index + 1}',
            classCode: '0 học phần',
            id: 'class_$index',
            description: 'Mô tả lớp học',
            createdBy: 'teacher_$index',
            createdAt: DateTime.now(),
            isDeleted: false,
          ),
          hasIcon: false,
        ),
    );

    return HorizontalScrollSection(
      title: 'Lớp học',
      items: sampleClasses,
      height: 130,
    );
  }
}

// Categories section widget
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Duyệt theo chủ đề'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: const [
              CategoryItem(
                name: 'Ngôn ngữ',
                color: Colors.purple,
                icon: Icons.translate,
              ),
              CategoryItem(
                name: 'Khoa học',
                color: Colors.blue,
                icon: Icons.science,
              ),
              CategoryItem(
                name: 'Nghệ thuật',
                color: Colors.pink,
                icon: Icons.brush,
              ),
              CategoryItem(
                name: 'Toán học',
                color: Colors.amber,
                icon: Icons.calculate,
              ),
              CategoryItem(
                name: 'Khoa học xã hội',
                color: Colors.teal,
                icon: Icons.public,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Category item widget
class CategoryItem extends StatelessWidget {
  final String name;
  final Color color;
  final IconData icon;

  const CategoryItem({
    super.key,
    required this.name,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
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
}

// Reusable section title widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Reusable horizontal scroll section widget
class HorizontalScrollSection extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final double height;

  const HorizontalScrollSection({
    super.key,
    required this.title,
    required this.items,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        const SizedBox(height: 12),
        SizedBox(
          height: height,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            children: items,
          ),
        ),
      ],
    );
  }
}