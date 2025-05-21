import 'package:flutter/material.dart';
import '../../../../../../core/domain/dtos/class_dto.dart';
import '../../../../../../widgets/class_item.dart';

class ClassTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ClassRoomDto> classItems = [
      ClassRoomDto(
        className: 'tét',
        classCode: '0 học phần',
        id: '',
        description: '',
        createdBy: '',
        createdAt: DateTime.now(),
        isDeleted: true,
      ),
      ClassRoomDto(
        className: 'lớp toeic',
        classCode: '0 học phần',
        id: '',
        description: '',
        createdBy: '',
        createdAt: DateTime.now(),
        isDeleted: true,
      ),
    ];

    return Container(
      color: Colors.grey[50],
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: classItems.length,
        itemBuilder: (context, index) {
          return ClassItem(item: classItems[index], hasIcon: true,);
        },
      ),
    );
  }
}