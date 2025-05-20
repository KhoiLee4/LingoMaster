import 'package:flutter/material.dart';

import 'library_item_widget.dart';

class HocPhanTab extends StatelessWidget {
  final String selectedFilter;

  const HocPhanTab({Key? key, required this.selectedFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<LibraryItem> libraryItems = [
      LibraryItem(
        title: 'ETS RC2 test 2',
        subtitle: '95 thuật ngữ',
        author: 'KhoiLee04',
        date: 'Tháng 3 2025',
        avatar: '👤',
      ),
      LibraryItem(
        title: 'TOEIC Vocabulary',
        subtitle: '120 thuật ngữ',
        author: 'StudyHelper',
        date: 'Tháng 2 2025',
        avatar: '📚',
      ),
      LibraryItem(
        title: 'Business English',
        subtitle: '80 thuật ngữ',
        author: 'EngPro',
        date: 'Tháng 2 2025',
        avatar: '💼',
      ),
    ];

    // Lọc danh sách theo selectedFilter
    List<LibraryItem> filteredItems = libraryItems.where((item) {
      if (selectedFilter == 'Tất cả') return true;
      // Thêm logic lọc khác ở đây
      return true;
    }).toList();

    return Container(
      color: Colors.grey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Section
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Bộ lọc',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          Divider(height: 1, color: Colors.grey[300]),

          // Date Section
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Tháng 3 2025',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          // Library Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return LibraryItemWidget(item: filteredItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}