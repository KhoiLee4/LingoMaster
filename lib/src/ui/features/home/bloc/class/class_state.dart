import '../../../../../../core/domain/dtos/classroom/classroom_dto.dart';

abstract class ClassState {}

class ClassInitial extends ClassState {}
class ClassLoading extends ClassState {}
class ClassLoaded extends ClassState {
  final List<ClassRoomDto>? classes;
  ClassLoaded(this.classes);
}
class ClassError extends ClassState {
  final String message;
  ClassError(this.message);
}
