import 'package:bloc/bloc.dart';
import 'package:lingo_master/core/domain/dtos/Folder/folder_dto.dart';

import '../../../../../../core/data/NativeService/folder_service.dart';
import 'folder_event.dart';
import 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  final FolderService folderService;

  FolderBloc(this.folderService) : super(FolderInitial()) {
    on<LoadFolders>((event, emit) async {
      emit(FolderLoading());
      try {
        final folders = await folderService.getAllFoldersAsync();
        emit(FolderLoaded(folders.data));
      } catch (e) {
        emit(FolderError(e.toString()));
      }
    });
  }
}
