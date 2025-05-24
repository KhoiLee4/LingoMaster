import 'package:bloc/bloc.dart';

import '../../../../../core/data/NativeService/class_folder_service.dart';
import '../../../../../core/data/NativeService/class_service.dart';
import '../../../../../core/data/NativeService/class_set_service.dart';
import 'class_event.dart';
import 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final ClassRoomService classService;
  final ClassroomSetService classSetService;
  final ClassroomFolderService classFolderService;
  final String id;

  ClassBloc(
      this.classService, this.classSetService, this.classFolderService, this.id)
      : super(ClassInitial()) {
    on<LoadClasses>((event, emit) async {
      emit(ClassLoading());
      try {
        final courses = await classSetService.getAllSetByClassroomId(id);
        final folders = await classFolderService.getAllFolderByClassroomId(id);
        final classs = await classService.getClassRoomById(id);
        emit(ClassLoaded(classs.data!, courses.data, folders.data));
      } catch (e) {
        emit(ClassError(e.toString()));
      }
    });
  }
}
