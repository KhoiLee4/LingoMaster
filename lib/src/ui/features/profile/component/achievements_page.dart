import 'package:flutter/material.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          // Status bar with time and icons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '21:56',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.wifi, size: 18),
                        const SizedBox(width: 2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '41.0',
                              style: TextStyle(fontSize: 10),
                            ),
                            const Text(
                              'KB/s',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Vô',
                          style: TextStyle(fontSize: 10),
                        ),
                        const Text(
                          'LTE',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.signal_cellular_alt, size: 18),
                    const SizedBox(width: 8),
                    const Icon(Icons.signal_cellular_alt, size: 18),
                    const SizedBox(width: 8),
                    Container(
                      width: 40,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black38),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              '58',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // App bar with back button and title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                const Text(
                  'Thành tựu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Content area
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: const [
                AchievementCalendarPage(),
                AchievementStreakPage(),
              ],
            ),
          ),

          // Android navigation buttons
          Container(
            height: 40,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Icon(Icons.menu, color: Colors.grey.shade700),
                ),
                Expanded(
                  child: Icon(Icons.crop_square, color: Colors.grey.shade700),
                ),
                Expanded(
                  child: Icon(Icons.arrow_back_ios, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AchievementCalendarPage extends StatelessWidget {
  const AchievementCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Mới đạt được',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Người ghép đôi',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 24),

            // Badge icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF11B3FC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF081D58),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.star,
                          size: 40,
                          color: Colors.lightBlue.shade200,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 15,
                        child: Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            // Date range
            const Text(
              '1 tháng 4 - 30 tháng 4',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Calendar
            Expanded(
              child: Column(
                children: [
                  // Days of week
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDayHeader('CN'),
                      _buildDayHeader('T2'),
                      _buildDayHeader('T3'),
                      _buildDayHeader('T4'),
                      _buildDayHeader('T5'),
                      _buildDayHeader('T6'),
                      _buildDayHeader('T7'),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Week 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDayCell('30', isGreyed: true),
                      _buildDayCell('31', isGreyed: true),
                      _buildDayCell('1'),
                      _buildDayCell('2'),
                      _buildDayCell('3'),
                      _buildDayCell('4'),
                      _buildDayCell('5'),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Week 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDayCell('6'),
                      _buildDayCell('7'),
                      _buildDayCell('8'),
                      _buildDayCell('9'),
                      _buildDayCell('10'),
                      _buildDayCell('11'),
                      _buildDayCell('12'),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Week 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDayCell('13', isHighlighted: true),
                      _buildDayCell('14', isHighlighted: true),
                      _buildDayCell('15', isActive: true),
                      _buildDayCell('16', isHighlighted: true),
                      _buildDayCell('17', isHighlighted: true),
                      _buildDayCell('18', isHighlighted: true),
                      _buildDayCell('19', isHighlighted: true),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Week 4
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDayCell('20'),
                      _buildDayCell('21'),
                      _buildDayCell('22'),
                      _buildDayCell('23'),
                      _buildDayCell('24'),
                      _buildDayCell('25'),
                      _buildDayCell('26'),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Week 5
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDayCell('27'),
                      _buildDayCell('28'),
                      _buildDayCell('29'),
                      _buildDayCell('30'),
                      _buildDayCell('1', isGreyed: true),
                      _buildDayCell('2', isGreyed: true),
                      _buildDayCell('3', isGreyed: true),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayHeader(String text) {
    return SizedBox(
      width: 35,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDayCell(String text, {bool isActive = false, bool isGreyed = false, bool isHighlighted = false}) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? Colors.orange
            : isHighlighted
            ? const Color(0xFFFEF0E1)
            : Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isGreyed
                  ? Colors.grey.shade300
                  : isActive
                  ? Colors.white
                  : Colors.black,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isActive)
            Positioned(
              bottom: 2,
              child: Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AchievementStreakPage extends StatelessWidget {
  const AchievementStreakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Current streak
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                const Divider(),
                const SizedBox(height: 16),
                const Text(
                  'Chuỗi hiện tại',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '1 tuần',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 24),

                // Progress visualization
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF0E1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF0E1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      'assets/flame.png',
                      height: 40,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Learning achievements
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Học tập',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Achievement badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAchievementBadge(
                        icon: Icons.chat_bubble_outline,
                        title: 'Tập sự thẻ ghi nhớ',
                        date: 'Đạt được vào\n24/09/2024',
                        color: Colors.blue,
                      ),
                      _buildAchievementBadge(
                        icon: Icons.flag,
                        title: 'Học viên tích cực',
                        date: 'Đạt được vào\n05/03/2025',
                        color: Colors.blue,
                        hasPath: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // More badges (grayed out and colored)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAchievementBadge(
                        icon: Icons.headphones,
                        title: '',
                        date: '',
                        color: Colors.grey.shade300,
                        isGrayed: true,
                      ),
                      _buildAchievementBadge(
                        icon: Icons.chat_bubble_outline,
                        title: '',
                        date: '',
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge({
    required IconData icon,
    required String title,
    required String date,
    required Color color,
    bool isGrayed = false,
    bool hasPath = false,
  }) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: isGrayed ? color.withOpacity(0.5) : color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isGrayed ? Colors.grey.shade400 : const Color(0xFF081D58),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  if (hasPath)
                    Center(
                      child: CustomPaint(
                        size: const Size(60, 40),
                        painter: PathPainter(),
                      ),
                    ),
                  Center(
                    child: Icon(
                      icon,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 15,
                    child: Icon(
                      Icons.star,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (!isGrayed) ...[
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.5, size.height * 0.5);

    // Add dots
    for (int i = 0; i < 4; i++) {
      double x = size.width * 0.5 + (i * 10);
      if (x < size.width * 0.8) {
        canvas.drawCircle(
          Offset(x, size.height * 0.5),
          2,
          Paint()..color = Colors.lightBlue,
        );
      }
    }

    path.lineTo(size.width * 0.8, size.height * 0.5);

    // Draw yellow dot at the end
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.5),
      5,
      Paint()..color = Colors.amber,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}