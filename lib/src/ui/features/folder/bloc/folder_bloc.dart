import 'package:bloc/bloc.dart';
import '../../../../../core/data/NativeService/folder_service.dart';
import '../../../../../core/data/NativeService/folder_set_service.dart';
import 'folder_event.dart';
import 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  final FolderService folderService;
  final FolderSetService folderCourseService;
  final String id;

  FolderBloc(this.folderService, this.folderCourseService, this.id) : super(FolderInitial()) {
    on<LoadFolders>((event, emit) async {
      emit(FolderLoading());
      try {
        final folder = await folderService.getFolderByIdAsync(id);
        final courses = await folderCourseService.getAllSetsByFolderId(id);
        emit(FolderLoaded(courses.data, folder.data!));
      } catch (e) {
        emit(FolderError(e.toString()));
      }
    });
  }
}