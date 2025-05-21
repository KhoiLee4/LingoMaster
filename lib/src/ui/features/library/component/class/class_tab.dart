import 'package:flutter/material.dart';
import 'class_item_widget.dart';

class ClassTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ClassItem> classItems = [
      ClassItem(
        title: 'tét',
        subtitle: '0 học phần',
      ),
      ClassItem(
        title: 'lớp toeic',
        subtitle: '62 học phần',
      ),
    ];

    return Container(
      color: Colors.grey[50],
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: classItems.length,
        itemBuilder: (context, index) {
          return ClassItemWidget(item: classItems[index]);
        },
      ),
    );
  }
}