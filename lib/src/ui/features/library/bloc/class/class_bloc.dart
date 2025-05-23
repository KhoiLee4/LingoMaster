import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_master/core/data/NativeService/class_service.dart';
import 'package:lingo_master/core/data/NativeService/class_user_service.dart';
import 'package:lingo_master/core/domain/models/session.dart';
import 'package:lingo_master/src/ui/features/library/bloc/class/class_event.dart';
import 'package:lingo_master/src/ui/features/library/bloc/class/class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final ClassRoomUserService classRoomService;

  ClassBloc(this.classRoomService) : super(ClassInitial()) {
    on<LoadClasses>((event, emit) async {
      emit(ClassLoading());
      try {
       
        
        final response = await classRoomService.getAllClassByUserId(Session.user!.Id!);
        if (response == null) {
          print('❌ Response is null');
          emit(ClassError('Failed to load classes: response is null'));
          return;
        }
        // Check if response is successful
        if (response.data != null) {
          print('✅ Classes loaded successfully: ${response.data!.length} classes');
          emit(ClassLoaded(response.data));
        } else {
          print('⚠️ No classes data in response');
          emit(ClassLoaded([])); // Empty list instead of null
        }
        
      } catch (e, stackTrace) {
        emit(ClassError('Failed to load classes: ${e.toString()}'));
      }
    });
  }
}