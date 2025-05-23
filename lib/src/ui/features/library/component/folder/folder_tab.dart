import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_master/core/data/NativeService/folder_user_service.dart';
import 'package:lingo_master/core/domain/models/session.dart';
import 'package:lingo_master/src/ui/features/library/bloc/folder/folder_bloc.dart';
import 'package:lingo_master/src/ui/features/library/bloc/folder/folder_event.dart';
import 'package:lingo_master/src/ui/features/library/bloc/folder/folder_state.dart';

import '../../../../../../core/domain/dtos/Folder/folder_dto.dart';
import '../../../../../../widgets/folder_item.dart';
class FolderProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LibFolderBloc>(
      create: (context) {
        // Add debug info
        print('🚀 Creating ClassBloc...');
        print('📱 User session: ${Session.user != null ? "exists" : "null"}');
        if (Session.user != null) {
          print('👤 User ID: ${Session.user!.Id}');
        }
        
        final bloc = LibFolderBloc(FolderUserService());
        // Trigger loading folders immediately after creating the bloc
        bloc.add(LibLoadFolder());
        return bloc;
      },
      child: FolderTab(),
    );
  }
}
class FolderTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<FolderDto> folderItems = [
      
    ];

    // return Container(
    //   color: Colors.grey[50],
    //   child: ListView.builder(
    //     padding: EdgeInsets.all(16),
    //     itemCount: folderItems.length,
    //     itemBuilder: (context, index) {
    //       return FolderItem(item: folderItems[index]);
    //     },
    //   ),
    // );
    return BlocBuilder<LibFolderBloc, LibFolderState>(
      builder: (context, state) {
        if (state is LibFolderLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Đang tải danh sách lớp học...'),
              ],
            ),
          );
        } else if (state is LibFolderLoaded) {
          return Container(
            color: Colors.grey[50],
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: state.folders!.length,
              itemBuilder: (context, index) {
                return FolderItem(item: state.folders![index]);
              },
            ),
          );
        } else if (state is LibForlderError) {
          return Center(
            child: Text('Lỗi khi tải danh sách lớp học: ${state.message}'),
          );
        }
        return Container();
      },
    );
  }
}
