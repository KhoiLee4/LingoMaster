import 'package:flutter/material.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  bool _showMenu = false;
  bool _showBottomSheet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
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
            children: [
              const SizedBox(height: 20),
              const Icon(
                Icons.folder,
                size: 60,
                color: Color(0xFF6E7795),
              ),
              const SizedBox(height: 16),
              const Text(
                'test',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7FC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Thư mục này trống.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6E7795),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showBottomSheet)
            GestureDetector(
              onTap: () {
                setState(() {
                  _showBottomSheet = false;
                });
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
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
            icon: Icon(Icons.crop_square),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _showBottomSheet
          ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                _buildActionItem(
                  icon: Icons.edit,
                  label: 'Sửa',
                  color: Colors.black54,
                ),
                const Divider(height: 1),
                _buildActionItem(
                  icon: Icons.share,
                  label: 'Chia sẻ',
                  color: Colors.black54,
                ),
                const Divider(height: 1),
                _buildActionItem(
                  icon: Icons.delete,
                  label: 'Xóa',
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      )
          : null,
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _showBottomSheet = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(width: 24),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Show bottom sheet after a delay to simulate button press
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showBottomSheet = true;
        });
      }
    });
  }
}