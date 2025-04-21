import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  bool _showOptionsMenu = false;

  final List<WordCard> vocabulary = [
    WordCard("employee", "(n) nhân viên"),
    WordCard("except", "(prep., conj) trừ ra, không kể, trừ phi"),
    WordCard("organize", "(v) tổ chức, sắp xếp"),
    WordCard("benefit", "(n) lợi ích; (v) được lợi"),
    WordCard("contract", "(n) hợp đồng; (v) ký kết"),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (currentIndex != next) {
        setState(() {
          currentIndex = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleOptionsMenu() {
    setState(() {
      _showOptionsMenu = !_showOptionsMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDefault,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDefault,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.neutralGray600,
            size: 30,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: AppColors.neutralGray600,
              size: 28,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.neutralGray600,
              size: 30,
            ),
            onPressed: _toggleOptionsMenu,
          ),
        ],
      ),
      body: Stack(
        // Changed from SingleChildScrollView to Stack
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Flash Card Section with PageView for horizontal swipe
                Container(
                  height: 250,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: vocabulary.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.neutralGray600,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                vocabulary[index].term,
                                style: TextStyle(
                                  fontSize: 36,
                                  color: AppColors.neutralGray700,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Icon(
                                Icons.fullscreen,
                                color: AppColors.neutralGray600,
                                size: 36,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Dynamic Dots Indicator
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < vocabulary.length; i++)
                        buildDotIndicator(i),
                    ],
                  ),
                ),

                // Upgrade Button
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1A237E), Color(0xFF5C6BC0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Thăng cấp với Q+",
                            style: TextStyle(
                              color: AppColors.primaryWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Nâng cấp ngay",
                          style: TextStyle(
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Title Section
                Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ETS RC2 test 2",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://via.placeholder.com/40",
                            ),
                            radius: 15,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "KhoiLee04",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.neutralGray500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            "95 thuật ngữ",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.neutralGray900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Action Buttons
                buildActionButton("assets/images/course/Card.png",
                    "Thẻ ghi nhớ", Colors.blue),
                buildActionButton(
                    "assets/images/course/study.png", "Học", Colors.blue),
                buildActionButton(
                    "assets/images/course/Test.png", "Kiểm tra", Colors.blue),
                buildActionButton("assets/images/course/graft_card.png",
                    "Ghép thẻ", Colors.blue),
                buildActionButton(
                    "assets/images/course/blast.png", "Blast", Colors.blue),
                buildActionButton(
                    "assets/images/course/block.png", "Khối hộp", Colors.blue),

                SizedBox(
                  height: 12,
                ),
                // Vocabulary List
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Thẻ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Thứ tự gốc",
                                  style: TextStyle(
                                    color: AppColors.neutralGray500,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.sort_outlined),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ...vocabulary.map((word) => buildWordItem(word)).toList(),
                    ],
                  ),
                ),

                // Learn Button
                Container(
                  // color: AppColors.primaryBlue,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Học bộ học phần này",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.primaryWhite),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),
              ],
            ),
          ),

          // Blurred overlay and bottom menu - This is what you want to add
          if (_showOptionsMenu)
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleOptionsMenu, // Close menu when tapping outside
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ),

          // Options menu at the bottom
          if (_showOptionsMenu)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Handle bar at top
                      Container(
                        width: 40,
                        height: 4,
                        margin: EdgeInsets.only(top: 12, bottom: 24),
                        decoration: BoxDecoration(
                          color: AppColors.neutralGray400,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // Menu items
                      _buildOptionMenuItem(
                        icon: Icons.download_outlined,
                        label: "Tải về để truy cập ngoại tuyến",
                        onTap: () {
                          _toggleOptionsMenu();
                          // Add your download logic here
                        },
                      ),
                      SizedBox(height: 8),
                      _buildOptionMenuItem(
                        icon: Icons.folder_outlined,
                        label: "Thêm vào thư mục",
                        onTap: () {
                          _toggleOptionsMenu();
                          // Add your folder logic here
                        },
                      ),
                      SizedBox(height: 8),
                      _buildOptionMenuItem(
                        icon: Icons.people_outlined,
                        label: "Thêm vào lớp học",
                        onTap: () {
                          _toggleOptionsMenu();
                          // Add your class logic here
                        },
                      ),
                      SizedBox(height: 8),
                      _buildOptionMenuItem(
                        icon: Icons.copy_outlined,
                        label: "Tạo một bản sao",
                        onTap: () {
                          _toggleOptionsMenu();
                          // Add your copy logic here
                        },
                      ),
                      SizedBox(height: 8),
                      _buildOptionMenuItem(
                        icon: Icons.share_outlined,
                        label: "Chia sẻ",
                        onTap: () {
                          _toggleOptionsMenu();
                          // Add your share logic here
                        },
                      ),
                      SizedBox(height: 8),
                      _buildOptionMenuItem(
                        icon: Icons.edit_outlined,
                        label: "Sửa",
                        onTap: () {
                          _toggleOptionsMenu();
                          // Add your edit logic here
                        },
                      ),
                      SizedBox(height: 8),
                      _buildOptionMenuItem(
                        icon: Icons.delete_outline,
                        label: "Xóa học phần",
                        onTap: () {
                          _toggleOptionsMenu();
                          // Add your delete logic here
                        },
                        textColor: Colors.red,
                        iconColor: Colors.red,
                      ),
                      SizedBox(height: 16), // Bottom padding
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Add this new method for menu items
  Widget _buildOptionMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? AppColors.neutralGray600,
        size: 28,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: textColor ?? AppColors.neutralGray500,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      dense: true,
      onTap: onTap,

    );

  }

  Widget buildDotIndicator(int index) {
    // Calculate dot size based on position
    double size;
    if (index == currentIndex) {
      // Current dot is larger and blue
      size = 10;
    } else if (index == 0 || index == vocabulary.length - 1) {
      // First and last dots are smaller when not active
      size = (currentIndex == index) ? 10 : 6;
    } else {
      // Middle dots are medium size
      size = 8;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: size,
      height: size,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: index == currentIndex
            ? AppColors.primaryBlue
            : AppColors.neutralGray700,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget buildActionButton(String image, String text, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutralGray400,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            // color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            image,
            width: 28,
            height: 28,
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
            color: AppColors.neutralGray700,
            fontWeight: FontWeight.bold,
          ),
        ),
        // trailing: Icon(Icons.chevron_right),
      ),
    );
  }

  Widget buildWordItem(WordCard word) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutralGray400,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    word.term,
                    style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.w500,
                        color: AppColors.neutralGray700),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.volume_up,
                            color: AppColors.neutralGray700),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.star_border,
                            color: AppColors.neutralGray700),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                word.definition,
                style: TextStyle(
                  color: AppColors.neutralGray900,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WordCard {
  final String term;
  final String definition;

  WordCard(this.term, this.definition);
}
