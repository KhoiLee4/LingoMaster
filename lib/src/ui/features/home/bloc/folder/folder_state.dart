import '../../../../../../core/domain/dtos/Folder/folder_dto.dart';

abstract class FolderState {}

class FolderInitial extends FolderState {}
class FolderLoading extends FolderState {}
class FolderLoaded extends FolderState {
  final List<FolderDto>? folders;
  FolderLoaded(this.folders);
}
class FolderError extends FolderState {
  final String message;
  FolderError(this.message);
}
