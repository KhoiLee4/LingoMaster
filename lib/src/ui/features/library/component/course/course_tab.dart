import 'package:flutter/material.dart';
import '../../../../../../core/domain/dtos/set_dto.dart';
import '../../../../../../widgets/course_item.dart';


class CourseTab extends StatelessWidget {
  final String selectedFilter;

  const CourseTab({Key? key, required this.selectedFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<SetDto> libraryItems = [
      SetDto(
        name: 'ETS RC2 test 2',
        cardCount: 95,
        id: '',
        topicId: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      SetDto(
        name: 'TOEIC Vocabulary',
        cardCount: 120,
        id: '',
        topicId: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      SetDto(
        name: 'Business English',
        cardCount: 80,
        id: '',
        topicId: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    // Lọc danh sách theo selectedFilter
    List<SetDto> filteredItems = libraryItems.where((item) {
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
                return CourseItem(item: filteredItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}