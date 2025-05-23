import 'package:flutter/material.dart';

import '../../../../../../core/domain/dtos/Folder/folder_dto.dart';
import '../../../../../../core/domain/dtos/folder_user/get_all_folder_by_user.dart';
import '../../../../../../widgets/folder_item.dart';

class FolderTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<GetAllFolderByUserIdResponse> folderItems = [
      GetAllFolderByUserIdResponse(
        folderId: '',
        folderName: '',
        nameUser: '',
      ),
      GetAllFolderByUserIdResponse(
        folderId: '',
        folderName: '',
        nameUser: '',
      ),
      GetAllFolderByUserIdResponse(
        folderId: '',
        folderName: '',
        nameUser: '',
      ),
      GetAllFolderByUserIdResponse(
        folderId: '',
        folderName: '',
        nameUser: '',
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
