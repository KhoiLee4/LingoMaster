import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';
import 'package:lingo_master/src/ui/features/home/component/home_page.dart';
import 'package:lingo_master/src/ui/features/library/component/library_page.dart';
import 'package:lingo_master/src/ui/features/profile/component/proflie_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // final List<Widget> _pages = [
  //   const HomeScreen(),
  //   const Center(
  //       child: Text('Lời giải', style: TextStyle(color: Colors.white))),
  //   const Center(child: Text('Thêm', style: TextStyle(color: Colors.white))),
  //   const LibraryScreen(),
  //   const ProfileScreen(),
  // ];

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
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        children: [
          Column(
            children: [
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
                    HomeScreen(),
                    Center(
                        child: Text('Lời giải',
                            style: TextStyle(color: Colors.white))),
                    Center(
                        child: Text('Thêm',
                            style: TextStyle(color: Colors.white))),
                    LibraryScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
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
        items: [
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
            icon: Icon(Icons.person),
            label: 'Hồ sơ',
          ),
        ],
      ),
    );
  }

  // Show bottom sheet for add button
  void _showAddBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.5,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
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
