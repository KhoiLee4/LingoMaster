import 'package:flutter/material.dart';

import '../../../../../../core/domain/dtos/Folder/folder_dto.dart';
import '../../../../../../widgets/folder_item.dart';

class FolderTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<FolderDto> folderItems = [
      FolderDto(
        name: 'test',
        id: '',
        isDeleted: false,
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
      ),
      FolderDto(
        name: 'test',
        id: '',
        isDeleted: false,
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
      ),
      FolderDto(
        name: 'test',
        id: '',
        isDeleted: false,
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
      ),
    ];

    return Container(
      color: Colors.grey[50],
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: folderItems.length,
        itemBuilder: (context, index) {
          return FolderItem(item: folderItems[index]);
        },
      ),
    );
  }
}
