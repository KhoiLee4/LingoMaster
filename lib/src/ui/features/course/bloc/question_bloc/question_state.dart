import '../../../../../../core/domain/dtos/question/multiple_choice_question_dto.dart';

abstract class QuestionState {}

class QuestionInitial extends QuestionState {}
class QuestionLoading extends QuestionState {}
class QuestionLoaded extends QuestionState {
  final List<MultipleChoiceQuestion>? questions;
  QuestionLoaded(this.questions);
}
class QuestionError extends QuestionState {
  final String message;
  QuestionError(this.message);
}