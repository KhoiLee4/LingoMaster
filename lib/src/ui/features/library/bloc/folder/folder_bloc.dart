

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_master/core/data/NativeService/folder_user_service.dart';
import 'package:lingo_master/core/domain/models/session.dart';
import 'package:lingo_master/src/ui/features/home/bloc/folder/folder_event.dart';
import 'package:lingo_master/src/ui/features/library/bloc/folder/folder_event.dart';
import 'package:lingo_master/src/ui/features/library/bloc/folder/folder_state.dart';




class LibFolderBloc extends Bloc<LibFolderEvent, LibFolderState> {
  final FolderUserService folderUserService;

  LibFolderBloc(this.folderUserService) : super(LibFolderInitial()) {
    on<LibLoadFolder>((event, emit) async {
      emit(LibFolderLoading());
      try {
       
        
        final response = await folderUserService.getAllFoldersByUserIdAsync(Session.user!.Id!);
        if (response == null) {
          print('❌ Response is null');
          emit(LibForlderError('Failed to load classes: response is null'));
          return;
        }
        // Check if response is successful
        if (response.data != null) {
          print('✅ Classes loaded successfully: ${response.data!.length} classes');
          emit(LibFolderLoaded(response.data));
        } else {
          print('⚠️ No classes data in response');
          emit(LibFolderLoaded([])); // Empty list instead of null
        }
        
      } catch (e, stackTrace) {
        emit(LibForlderError('Failed to load classes: ${e.toString()}'));
      }
    });
  }
}