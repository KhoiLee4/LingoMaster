import '../../../../../../core/domain/dtos/classroom_user/get_all_class_by_user_id_respone.dart';

abstract class ClassState {}

class ClassInitial extends ClassState {}
class ClassLoading extends ClassState {}
class ClassLoaded extends ClassState {
  final List<GetAllClassByUserIdRespone>? classes;
  ClassLoaded(this.classes);
}
class ClassError extends ClassState {
  final String message;
  ClassError(this.message);
}
