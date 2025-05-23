
import 'package:lingo_master/core/domain/dtos/classroom/classroom_dto.dart';
import 'package:lingo_master/core/domain/dtos/classroom_user/get_all_class_by_user_id_respone.dart';
import 'package:lingo_master/core/domain/dtos/folder/folder_dto.dart';

abstract class ClassState {}

class ClassInitial extends ClassState {}
class ClassLoading extends ClassState {}
class ClassLoaded extends ClassState {
late final List<GetAllClassByUserIdRespone>? classes;
  ClassLoaded(this.classes);
}
class ClassError extends ClassState {
  final String message;
  ClassError(this.message);
}
