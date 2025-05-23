import 'package:bloc/bloc.dart';
import 'package:lingo_master/core/data/NativeService/card_service.dart';
import 'package:lingo_master/core/data/NativeService/set_service.dart';
import 'package:lingo_master/src/ui/features/course/bloc/question_bloc/question_event.dart';
import 'package:lingo_master/src/ui/features/course/bloc/question_bloc/question_state.dart';

import '../../../../../../core/data/NativeService/question_service.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionsService questionsService;
  final CardService cardService;
  final String setId;

  QuestionBloc(this.questionsService, this.cardService, this.setId) : super(QuestionInitial()) {
    on<LoadQuestion>((event, emit) async {
      emit(QuestionLoading());
      try {
        final card = await cardService.getCardBySetId(setId);
        final questions = await questionsService.generateQuizQuestions(setId, questions: card.data?.length);
        emit(QuestionLoaded(questions.data));
      } catch (e) {
        emit(QuestionError(e.toString()));
      }
    });
  }

}