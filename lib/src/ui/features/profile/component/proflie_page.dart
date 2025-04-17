import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                              '15.0',
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

          // Profile and upgrade section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Nâng cấp',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Profile section with user name and avatar
          Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage('https://via.placeholder.com/80'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'KhoiLee04',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Settings button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                leading: Icon(Icons.settings, color: Colors.grey.shade600),
                title: const Text(
                  'Cài đặt của bạn',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {},
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Achievements section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Thành tựu',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Xem tất cả',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Streak card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  const Text(
                    'Chuỗi 1 tuần',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Flame icon with number
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/flame.png',
                        height: 60,
                        color: Colors.orange,
                      ),
                      const Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Hãy học vào tuần tới để duy trì chuỗi của bạn!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  // Calendar week view
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDayColumn('S', '13', false),
                      _buildDayColumn('M', '14', false),
                      _buildDayColumn('T', '15', true),
                      _buildDayColumn('W', '16', false),
                      _buildDayColumn('T', '17', false),
                      _buildDayColumn('F', '18', false),
                      _buildDayColumn('S', '19', false),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Bottom navigation bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, 'Trang chủ', false),
                _buildNavItem(Icons.description, 'Lời giải', false),
                _buildAddButton(),
                _buildNavItem(Icons.folder, 'Thư viện', false),
                _buildNavItem(Icons.person, 'Hồ sơ', true),
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

  Widget _buildDayColumn(String day, String date, bool isActive) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.orange.withOpacity(0.2) : Colors.transparent,
          ),
          child: Center(
            child: Text(
              date,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? Colors.orange : Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        if (isActive)
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
            ),
          ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Icon(Icons.add, color: Colors.grey.shade500),
    );
  }
}