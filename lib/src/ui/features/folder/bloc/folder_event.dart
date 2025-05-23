import 'package:equatable/equatable.dart';

abstract class FolderEvent extends Equatable {
  const FolderEvent();

  @override
  List<Object?> get props => [];
}

class LoadFolderSets extends FolderEvent {
  final String folderId;

  const LoadFolderSets(this.folderId);

  @override
  List<Object?> get props => [folderId];
}

class RefreshFolderSets extends FolderEvent {
  final String folderId;

  const RefreshFolderSets(this.folderId);

  @override
  List<Object?> get props => [folderId];
}
