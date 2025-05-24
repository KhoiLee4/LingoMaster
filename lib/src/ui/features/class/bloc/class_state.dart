import 'package:lingo_master/core/domain/dtos/class_folder/get_all_folder_by_classroom_Id_respone.dart';

import '../../../../../core/domain/dtos/classroom/classroom_dto.dart';
import '../../../../../core/domain/dtos/classroom_user/get_all_set_by_classroom_id_respone.dart';

abstract class ClassState {}

class ClassInitial extends ClassState {}
class ClassLoading extends ClassState {}
class ClassLoaded extends ClassState {
  final ClassRoomDto classs;
  final List<GetAllSetByClassroomIdRespone>? courses;
  final List<GetAllFolderByClassroomIdRespone>? folders;
  ClassLoaded(this.classs, this.courses, this.folders);
}
class ClassError extends ClassState {
  final String message;
  ClassError(this.message);
}
