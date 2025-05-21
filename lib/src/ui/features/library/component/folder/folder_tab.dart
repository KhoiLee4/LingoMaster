import 'package:flutter/material.dart';
import 'folder_item_widget.dart';

class FolderTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<FolderItem> folderItems = [
      FolderItem(
        title: 'test',
        author: 'KhoiLee04',
      ),
      FolderItem(
        title: 'kkkkk',
        author: 'KhoiLee04',
      ),
    ];

    return Container(
      color: Colors.grey[50],
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: folderItems.length,
        itemBuilder: (context, index) {
            return FolderItemWidget(item: folderItems[index]);
        },
      ),
    );
  }
}