import 'package:flutter/material.dart';

import '../../../../../../core/domain/dtos/set/set_dto.dart';
import '../../../../../../core/domain/dtos/set_user/created_set_dto.dart';
import '../../../../../../widgets/course_item.dart';

class CourseTab extends StatelessWidget {
  final String selectedFilter;

  const CourseTab({Key? key, required this.selectedFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CreatedSetDto> libraryItems = [
      CreatedSetDto(
        name: 'ETS RC2 test',
        id: 'course',
        totalCard: 96,
        nameOwner: '',
        createdAt: DateTime.now(),
        dateAccess: DateTime.now(),
      ),
      CreatedSetDto(
        name: 'ETS RC2 test',
        id: 'course',
        totalCard: 96,
        nameOwner: '',
        createdAt: DateTime.now(),
        dateAccess: DateTime.now(),
      ),
      CreatedSetDto(
        name: 'ETS RC2 test',
        id: 'course',
        totalCard: 96,
        nameOwner: '',
        createdAt: DateTime.now(),
        dateAccess: DateTime.now(),
      ),
    ];

    // Lọc danh sách theo selectedFilter
    List<CreatedSetDto> filteredItems = libraryItems.where((item) {
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
