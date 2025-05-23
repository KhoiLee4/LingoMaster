import 'package:bloc/bloc.dart';

import '../../../../../../core/data/NativeService/card_service.dart';
import 'course_event.dart';
import 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CardService cardService;
  final String setId;

  CourseBloc(this.cardService, this.setId) : super(CourseInitial()) {
    on<LoadCard>((event, emit) async {
      emit(CourseLoading());
      try {
        final folders = await cardService.getCardBySetId(setId);
        emit(CourseLoaded(folders.data));
      } catch (e) {
        emit(CourseError(e.toString()));
      }
    });
  }
}
