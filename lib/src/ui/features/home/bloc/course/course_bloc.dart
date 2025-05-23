import 'package:bloc/bloc.dart';
import 'package:lingo_master/core/domain/models/session.dart';

import '../../../../../../core/data/NativeService/set_service.dart';
import '../../../../../../core/data/NativeService/set_user_service.dart';
import 'course_event.dart';
import 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final SetUserService courseService;

  CourseBloc(this.courseService) : super(CourseInitial()) {
    on<LoadCourses>((event, emit) async {
      emit(CourseLoading());
      try {
        final courses = await courseService.getAllSetsByUserId(Session.user!.Id!);
        emit(CourseLoaded(courses.data));
      } catch (e) {
        emit(CourseError(e.toString()));
      }
    });
  }
}
