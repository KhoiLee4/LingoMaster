import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/NativeService/folder_set_service.dart';
import '../../../../../core/domain/dtos/folder_set/get_all_set_by_folder.dart';
import '../../../../../widgets/folder_item.dart';
import '../bloc/folder_bloc.dart';
import '../bloc/folder_event.dart';
import '../bloc/folder_state.dart';

class FolderScreenProvider extends StatelessWidget {
  final String? folderId;

  const FolderScreenProvider({super.key, this.folderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FolderBloc(
        apiService: context.read<FolderSetService>(),
      ),
      child: FolderScreen(id: folderId),
    );
  }
}

class FolderScreen extends StatefulWidget {
  final String? id;
  const FolderScreen({super.key, this.id});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  bool _showBottomSheet = false;
  bool _showAddOptions = false;
  bool _showFolderTypes = false;

  @override
  void initState() {
    super.initState();
    // Load folder sets when screen initializes
    if (widget.id != null) {
      context.read<FolderBloc>().add(LoadFolderSets(widget.id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              setState(() {
                _showAddOptions = true;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              setState(() {
                _showBottomSheet = true;
              });
              // _showOptionsBottomSheet();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // const FolderHeader(title: 'test'),
              //
              // // Folder content with BLoC
              // Expanded(
              //   child: BlocBuilder<FolderBloc, FolderState>(
              //     builder: (context, state) {
              //       if (state is FolderLoading) {
              //         return const Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       } else if (state is FolderLoaded) {
              //         if (state.isEmpty) {
              //           return const EmptyFolderContent();
              //         } else {
              //           return FolderContent(sets: state.sets);
              //         }
              //       } else if (state is FolderError) {
              //         return Center(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(
              //                 Icons.error_outline,
              //                 size: 64,
              //                 color: Colors.red[300],
              //               ),
              //               const SizedBox(height: 16),
              //               Text(
              //                 state.message,
              //                 style: const TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.red,
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //               const SizedBox(height: 16),
              //               ElevatedButton(
              //                 onPressed: () {
              //                   if (widget.id != null) {
              //                     context.read<FolderBloc>().add(
              //                       RefreshFolderSets(widget.id!),
              //                     );
              //                   }
              //                 },
              //                 child: const Text('Thử lại'),
              //               ),
              //             ],
              //           ),
              //         );
              //       } else {
              //         return const EmptyFolderContent();
              //       }
              //     },
              //   ),
              // ),
            ],
          ),

          // Add Options Dialog
          // if (_showAddOptions)
          //   AddOptionsDialog(
          //     onClose: () {
          //       setState(() {
          //         _showAddOptions = false;
          //       });
          //     },
          //     onCreateNew: () {
          //       setState(() {
          //         _showAddOptions = false;
          //         _showFolderTypes = true;
          //       });
          //     },
          //     onAddContent: () {
          //       setState(() {
          //         _showAddOptions = false;
          //       });
          //       // Refresh the folder content after adding
          //       if (widget.id != null) {
          //         context.read<FolderBloc>().add(RefreshFolderSets(widget.id!));
          //       }
          //     },
          //   ),

          // Folder Types Dialog
          // if (_showFolderTypes)
          //   FolderTypesDialog(
          //     onClose: () {
          //       setState(() {
          //         _showFolderTypes = false;
          //       });
          //     },
          //     onSelectType: () {
          //       setState(() {
          //         _showFolderTypes = false;
          //       });
          //       // Refresh the folder content after selecting type
          //       if (widget.id != null) {
          //         context.read<FolderBloc>().add(RefreshFolderSets(widget.id!));
          //       }
          //     },
          //   ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_square),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios_new),
            label: '',
          ),
        ],
      ),
    );
  }

  // void _showOptionsBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) {
  //       return OptionsBottomSheet(
  //         onClose: () {
  //           setState(() {
  //             _showBottomSheet = false;
  //           });
  //         },
  //       );
  //     },
  //   ).then((_) {
  //     setState(() {
  //       _showBottomSheet = false;
  //     });
  //   });
  // }
}

// Updated FolderContent Widget
class FolderContent extends StatelessWidget {
  final List<GetAllSetsByFolderIdResponse> sets;

  const FolderContent({
    Key? key,
    required this.sets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Get folder ID from the parent widget
        final folderScreen = context.findAncestorWidgetOfExactType<FolderScreen>();
        if (folderScreen?.id != null) {
          context.read<FolderBloc>().add(RefreshFolderSets(folderScreen!.id!));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gần đây',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF252638),
              ),
            ),
            const SizedBox(height: 16),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: sets.length,
            //     itemBuilder: (context, index) {
            //       final set = sets[index];
            //       return FolderItem(
            //         title: set.title ?? 'Untitled', // Adjust property names based on your model
            //         subtitle: set.description ?? 'No description', // Adjust property names
            //         icon: Icons.library_books,
            //         iconColor: Colors.blue,
            //         backgroundColor: Colors.blue.withOpacity(0.1),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

