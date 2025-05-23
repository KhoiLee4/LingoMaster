import 'package:bloc/bloc.dart';

import '../../../../../../core/data/NativeService/class_service.dart';
import 'class_event.dart';
import 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final ClassRoomService classService;

  ClassBloc(this.classService) : super(ClassInitial()) {
    on<LoadClasses>((event, emit) async {
      emit(ClassLoading());
      try {
        final classes = await classService.getAllClassRooms();
        emit(ClassLoaded(classes.data));
      } catch (e) {
        emit(ClassError(e.toString()));
      }
    });
  }
}
