import 'package:flutter/material.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showMenu = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Lớp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              setState(() {
                _showMenu = !_showMenu;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '0 học phần',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'tết',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'HỌC PHẦN'),
                  Tab(text: 'THÀNH VIÊN'),
                ],
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                indicatorWeight: 3,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // First tab content - Học phần
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Lớp học này không có học phần nào',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              'Thêm học phần để chia sẻ với lớp của bạn.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Thêm học phần',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Second tab content - Thành viên
                    ListView(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            // backgroundImage: NetworkError(
                            //   "https://placedog.net/100/100",
                            // ),
                            radius: 20,
                            backgroundColor: Colors.grey[300],
                          ),
                          title: const Text(
                            'KhoiLee04',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Popup menu
          if (_showMenu)
            Positioned(
              top: 0,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildMenuItem('Mời thành viên', Icons.person_add_outlined),
                    _buildMenuItem('Thêm học phần', Icons.add_box_outlined),
                    _buildMenuItem('Thêm thư mục', Icons.folder_outlined),
                    _buildMenuItem('Báo cáo', Icons.flag_outlined),
                    _buildMenuItem('Bỏ lớp học', Icons.logout_outlined),
                  ],
                ),
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
            icon: Icon(Icons.check_box_outline_blank),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios_new),
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
        setState(() {
          _showMenu = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: Colors.black54),
              const SizedBox(width: 12),
            ],
            Text(title),
          ],
        ),
      ),
    );
  }
}

// Just a placeholder for network image that might fail to load
// class NetworkError extends ImageProvider<NetworkError> {
//   final String url;
//
//   NetworkError(this.url);
//
//   @override
//   Future<NetworkError> obtainKey(ImageConfiguration configuration) {
//     return SynchronousFuture<NetworkError>(this);
//   }
//
//   @override
//   ImageStreamCompleter load(NetworkError key, DecoderCallback decode) {
//     return NetworkImage(url).load(NetworkImage(url), decode);
//   }
// }