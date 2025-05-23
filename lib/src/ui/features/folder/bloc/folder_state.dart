import 'package:equatable/equatable.dart';

import '../../../../../core/domain/dtos/folder_set/get_all_set_by_folder.dart';

abstract class FolderState extends Equatable {
  const FolderState();

  @override
  List<Object?> get props => [];
}

class FolderInitial extends FolderState {}

class FolderLoading extends FolderState {}

class FolderLoaded extends FolderState {
  final List<GetAllSetsByFolderIdResponse> sets;
  final bool isEmpty;

  const FolderLoaded({
    required this.sets,
    required this.isEmpty,
  });

  @override
  List<Object?> get props => [sets, isEmpty];
}

class FolderError extends FolderState {
  final String message;
  final List<String> errors;

  const FolderError({
    required this.message,
    this.errors = const [],
  });

  @override
  List<Object?> get props => [message, errors];
}
