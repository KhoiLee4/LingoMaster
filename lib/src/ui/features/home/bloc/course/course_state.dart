import '../../../../../../core/domain/dtos/set/set_dto.dart';
import '../../../../../../core/domain/dtos/set_user/created_set_dto.dart';

abstract class CourseState {}

class CourseInitial extends CourseState {}
class CourseLoading extends CourseState {}
class CourseLoaded extends CourseState {
  final List<CreatedSetDto>? courses;
  CourseLoaded(this.courses);
}
class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}
