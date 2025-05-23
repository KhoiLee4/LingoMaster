import '../../../../../../core/domain/dtos/Card/card_dto.dart';

abstract class CourseState {}

class CourseInitial extends CourseState {}
class CourseLoading extends CourseState {}
class CourseLoaded extends CourseState {
  final List<CardDto>? cards;
  CourseLoaded(this.cards);
}
class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}