
import 'package:lingo_master/core/domain/dtos/classroom/classroom_dto.dart';
import 'package:lingo_master/core/domain/dtos/classroom_user/get_all_class_by_user_id_respone.dart';
import 'package:lingo_master/core/domain/dtos/folder/folder_dto.dart';
import 'package:lingo_master/core/domain/dtos/folder_user/get_all_folder_by_user.dart';

abstract class LibFolderState {}

class LibFolderInitial extends LibFolderState {}
class LibFolderLoading extends LibFolderState {}
class LibFolderLoaded extends LibFolderState {
late final List<GetAllFolderByUserIdResponse>? folders;
  LibFolderLoaded(this.folders);
}
class LibForlderError extends LibFolderState {
  final String message;
  LibForlderError(this.message);
}


