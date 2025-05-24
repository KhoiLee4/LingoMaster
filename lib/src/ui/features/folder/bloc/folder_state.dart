import '../../../../../core/domain/dtos/Folder/folder_dto.dart';
import '../../../../../core/domain/dtos/folder_set/get_all_set_by_folder.dart';

abstract class FolderState {}

class FolderInitial extends FolderState {}
class FolderLoading extends FolderState {}
class FolderLoaded extends FolderState {
  final List<GetAllSetsByFolderIdResponse>? courses;
  final FolderDto folder;
  FolderLoaded(this.courses, this.folder);
}
class FolderError extends FolderState {
  final String message;
  FolderError(this.message);
}