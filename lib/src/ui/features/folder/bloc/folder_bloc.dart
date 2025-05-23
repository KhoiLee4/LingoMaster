import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/NativeService/folder_set_service.dart';
import 'folder_event.dart';
import 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  final FolderSetService
      _apiService; // Replace with your actual service class name

  FolderBloc({required FolderSetService apiService})
      : _apiService = apiService,
        super(FolderInitial()) {
    on<LoadFolderSets>(_onLoadFolderSets);
    on<RefreshFolderSets>(_onRefreshFolderSets);
  }

  Future<void> _onLoadFolderSets(
    LoadFolderSets event,
    Emitter<FolderState> emit,
  ) async {
    emit(FolderLoading());
    await _loadSets(event.folderId, emit);
  }

  Future<void> _onRefreshFolderSets(
    RefreshFolderSets event,
    Emitter<FolderState> emit,
  ) async {
    // Don't emit loading state for refresh to avoid UI flicker
    await _loadSets(event.folderId, emit);
  }

  Future<void> _loadSets(String folderId, Emitter<FolderState> emit) async {
    try {
      final response = await _apiService.getAllSetsByFolderId(folderId);

      if (response.success && response.data != null) {
        final sets = response.data!;
        emit(FolderLoaded(
          sets: sets,
          isEmpty: sets.isEmpty,
        ));
      } else {
        emit(FolderError(
          message: response.message ?? 'Failed to load folder sets',
          errors: response.errors ?? [],
        ));
      }
    } catch (e) {
      emit(FolderError(
        message: 'An unexpected error occurred',
        errors: [e.toString()],
      ));
    }
  }
}
