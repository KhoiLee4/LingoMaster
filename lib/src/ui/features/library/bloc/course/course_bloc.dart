

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_master/core/data/NativeService/set_service.dart';
import 'package:lingo_master/core/data/NativeService/set_user_service.dart';
import 'package:lingo_master/core/domain/models/session.dart';
import 'package:lingo_master/src/ui/features/library/bloc/course/course_event.dart';
import 'package:lingo_master/src/ui/features/library/bloc/course/course_state.dart';
import 'package:lingo_master/widgets/course_item.dart';

class LibCourseBloc extends Bloc<LibCourseEvent, LibCourseState> {
  final SetUserService setService;

  LibCourseBloc(this.setService) : super(LibCourseInitial()) {
    on<LibLoadCourse>((event, emit) async {
      emit(LibCourseLoading());
      try {
       
        
        final response = await setService.getAllSetsByUserId(Session.user!.Id!);
        if (response == null) {
          print('❌ Response is null');
          emit(LibCourseError('Failed to load classes: response is null'));
          return;
        }
        // Check if response is successful
        if (response.data != null) {
          print('✅ Classes loaded successfully: ${response.data!.length} classes');
          emit(LibCourseLoaded(response.data));
        } else {
          print('⚠️ No classes data in response');
          emit(LibCourseLoaded([])); // Empty list instead of null
        }
        
      } catch (e, stackTrace) {
        emit(LibCourseError('Failed to load classes: ${e.toString()}'));
      }
    });
  }
}