import 'package:bloc/bloc.dart';
import 'package:lingo_master/core/domain/models/session.dart';
import '../../../../../../core/data/NativeService/folder_user_service.dart';
import 'folder_event.dart';
import 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  final FolderUserService folderService;

  FolderBloc(this.folderService) : super(FolderInitial()) {
    on<LoadFolders>((event, emit) async {
      emit(FolderLoading());
      try {
        final folders = await folderService.getAllFoldersByUserIdAsync(Session.user!.Id!);
        emit(FolderLoaded(folders.data));
      } catch (e) {
        emit(FolderError(e.toString()));
      }
    });
  }
}