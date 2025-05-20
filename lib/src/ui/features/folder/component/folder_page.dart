import 'package:flutter/material.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({Key? key}) : super(key: key);

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  bool _hasContent = false;
  bool _showBottomSheet = false;
  bool _showAddOptions = false;
  bool _showFolderTypes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAAACBA),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              setState(() {
                _showAddOptions = true;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              setState(() {
                _showBottomSheet = true;
              });
              _showOptionsBottomSheet();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Folder icon and title
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: const Color(0xFF5E6175), width: 2),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.folder,
                          color: Color(0xFF5E6175),
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'test',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF252638),
                      ),
                    ),
                  ],
                ),
              ),

              // Folder content
              if (_hasContent)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Gần đây',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF252638),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FolderItem(
                          title: 'ETS RC2 test 2',
                          subtitle: 'Học phần • 95 thuật ngữ • Tác giả: bạn',
                          icon: Icons.library_books,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.blue.withOpacity(0.1),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Thư mục này trống.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF5E6175),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Add Options Dialog
          if (_showAddOptions)
            _buildAddOptionsDialog(),

          // Folder Types Dialog
          if (_showFolderTypes)
            _buildFolderTypesDialog(),
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
      ),
    );
  }

  void _showOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.grey),
                title: const Text('Sửa'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _showBottomSheet = false;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.share_outlined, color: Colors.grey),
                title: const Text('Chia sẻ'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _showBottomSheet = false;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('Xóa', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _showBottomSheet = false;
                  });
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    ).then((_) {
      setState(() {
        _showBottomSheet = false;
      });
    });
  }

  Widget _buildAddOptionsDialog() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showAddOptions = false;
          });
        },
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Thêm vào thư mục',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showAddOptions = false;
                          _showFolderTypes = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 10),
                          Text('Tạo mới'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    'Học phần',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.library_books,
                        color: Colors.blue,
                      ),
                    ),
                    title: const Text('ETS RC2 test 2'),
                    subtitle: const Text('Học phần • 95 thuật ngữ • Tá...'),
                    trailing: const Icon(Icons.add_circle_outline),
                    onTap: () {
                      setState(() {
                        _showAddOptions = false;
                        _hasContent = true;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFolderTypesDialog() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showFolderTypes = false;
          });
        },
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.library_books,
                          color: Colors.blue,
                        ),
                      ),
                      title: const Text('Học phần'),
                      onTap: () {
                        setState(() {
                          _showFolderTypes = false;
                          _hasContent = true;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FolderItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const FolderItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        title: Text(title),
        subtitle: Text(
          subtitle,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {},
      ),
    );
  }
}