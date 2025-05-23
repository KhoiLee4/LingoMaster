import '../../../../../../core/domain/dtos/folder_user/get_all_folder_by_user.dart';

abstract class FolderState {}

class FolderInitial extends FolderState {}
class FolderLoading extends FolderState {}
class FolderLoaded extends FolderState {
  final List<GetAllFolderByUserIdResponse>? folders;
  FolderLoaded(this.folders);
}
class FolderError extends FolderState {
  final String message;
  FolderError(this.message);
}