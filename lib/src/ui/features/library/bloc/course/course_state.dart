
import 'package:lingo_master/core/domain/dtos/Card/create_card_dto.dart';
import 'package:lingo_master/core/domain/dtos/set/set_dto.dart';
import 'package:lingo_master/core/domain/dtos/set_user/created_set_dto.dart';

abstract class LibCourseState {}

class LibCourseInitial extends LibCourseState {}
class LibCourseLoading extends LibCourseState {}
class LibCourseLoaded extends LibCourseState {
late final List<CreatedSetDto>? sets;
  LibCourseLoaded(this.sets);
}
class LibCourseError extends LibCourseState {
  final String message;
  LibCourseError(this.message);
}
