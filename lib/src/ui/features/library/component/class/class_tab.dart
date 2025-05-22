import 'package:flutter/material.dart';
import '../../../../../../core/domain/dtos/classroom/classroom_dto.dart';
import '../../../../../../widgets/class_item.dart';

class ClassTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ClassRoomDto> classItems = [
      ClassRoomDto(
        name: 'Lớp học',
        classCode: '0 học phần',
        id: 'class',
        description: 'Mô tả lớp học',
        isDelete: false,
        isPublic: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      ClassRoomDto(
        name: 'Lớp học',
        classCode: '0 học phần',
        id: 'class',
        description: 'Mô tả lớp học',
        isDelete: false,
        isPublic: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      ClassRoomDto(
        name: 'Lớp học',
        classCode: '0 học phần',
        id: 'class',
        description: 'Mô tả lớp học',
        isDelete: false,
        isPublic: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    return Container(
      color: Colors.grey[50],
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: classItems.length,
        itemBuilder: (context, index) {
          return ClassItem(
            item: classItems[index],
            hasIcon: true,
          );
        },
      ),
    );
  }
}
