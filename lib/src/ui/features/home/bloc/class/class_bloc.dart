import 'package:bloc/bloc.dart';

import '../../../../../../core/data/NativeService/class_user_service.dart';
import '../../../../../../core/domain/models/session.dart';
import 'class_event.dart';
import 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final ClassRoomUserService classService;

  ClassBloc(this.classService) : super(ClassInitial()) {
    on<LoadClasses>((event, emit) async {
      emit(ClassLoading());
      try {
        final classes = await classService.getAllClassByUserId(Session.user!.Id!);
        emit(ClassLoaded(classes.data));
      } catch (e) {
        emit(ClassError(e.toString()));
      }
    });
  }
}
