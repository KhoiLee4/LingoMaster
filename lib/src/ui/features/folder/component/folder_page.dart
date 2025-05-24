import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/NativeService/folder_service.dart';
import '../../../../../core/data/NativeService/folder_set_service.dart';
import '../../../../../core/domain/dtos/folder_set/get_all_set_by_folder.dart';
import '../bloc/folder_bloc.dart';
import '../bloc/folder_event.dart';
import '../bloc/folder_state.dart';

class FolderProvider extends StatelessWidget {
  final String? id;

  const FolderProvider({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FolderBloc>(
      create: (context) {
        final bloc = FolderBloc(FolderService(), FolderSetService(), id!);
        // Trigger loading folders immediately after creating the bloc
        bloc.add(LoadFolders());
        return bloc;
      },
      child: FolderScreen(id: id),
    );
  }
}

class FolderScreen extends StatefulWidget {
  final String? id;

  const FolderScreen({super.key, required this.id});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  bool _showBottomSheet = false;
  bool _showAddOptions = false;
  bool _showFolderTypes = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Ensure loading is triggered after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<FolderBloc>().add(LoadFolders());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              if (mounted) {
                setState(() => _showAddOptions = true);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              if (mounted) {
                setState(() => _showBottomSheet = true);
                _showOptionsBottomSheet();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              BlocConsumer<FolderBloc, FolderState>(
                listener: (context, state) {
                  if (state is FolderLoading) {
                    setState(() => _isLoading = true);
                  } else {
                    setState(() => _isLoading = false);
                  }
                },
                builder: (context, state) {
                  if (state is FolderLoading || _isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is FolderLoaded) {
                    if (state.folder == null) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Chưa có thư mục nào',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    }
                    return FolderHeader(
                      folderName: state.folder.name,
                    );
                  } else if (state is FolderError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Lỗi: ${state.message}"),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                if (mounted) {
                                  context.read<FolderBloc>().add(LoadFolders());
                                }
                              },
                              child: const Text('Thử lại'),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
              _buildFolderContent(),
            ],
          ),
          if (_showAddOptions)
            AddOptionsDialog(
              onClose: () {
                if (mounted) {
                  setState(() => _showAddOptions = false);
                }
              },
              onCreateNew: () {
                if (mounted) {
                  setState(() {
                    _showAddOptions = false;
                    _showFolderTypes = true;
                  });
                }
              },
              onAddExisting: () {
                if (mounted) {
                  setState(() {
                    _showAddOptions = false;
                  });
                }
              },
            ),
          if (_showFolderTypes)
            FolderTypesDialog(
              onClose: () {
                if (mounted) {
                  setState(() => _showFolderTypes = false);
                }
              },
              onSelectType: () {
                if (mounted) {
                  setState(() {
                    _showFolderTypes = false;
                  });
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _buildFolderContent() {
    return const Expanded(
      child: FolderContentList(),
    );
  }

  void _showOptionsBottomSheet() {
    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => OptionsBottomSheet(
        onEdit: () => _handleBottomSheetAction(),
        onShare: () => _handleBottomSheetAction(),
        onDelete: () => _handleBottomSheetAction(),
      ),
    ).then((_) {
      if (mounted) {
        setState(() => _showBottomSheet = false);
      }
    });
  }

  void _handleBottomSheetAction() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    if (mounted) {
      setState(() => _showBottomSheet = false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// Folder Header Widget
class FolderHeader extends StatelessWidget {
  final String folderName;

  const FolderHeader({
    Key? key,
    required this.folderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: const Color(0xFF5E6175), width: 2),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.folder,
                color: Color(0xFF5E6175),
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            folderName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF252638),
            ),
          ),
        ],
      ),
    );
  }
}

// Folder Content List Widget
class FolderContentList extends StatefulWidget {
  const FolderContentList({Key? key}) : super(key: key);

  @override
  State<FolderContentList> createState() => _FolderContentListState();
}

class _FolderContentListState extends State<FolderContentList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderBloc, FolderState>(
      builder: (context, state) {
        if (state is FolderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FolderLoaded) {
          if (state.courses == null || state.courses!.isEmpty) {
            return const EmptyFolderView();
          }
          return Padding(
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
                Expanded(
                  child: ListView.builder(
                    itemCount: state.courses?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (index < (state.courses?.length ?? 0)) {
                        return FolderDetailItem(item: state.courses![index]);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is FolderError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lỗi: ${state.message}"),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (context.mounted) {
                      context.read<FolderBloc>().add(LoadFolders());
                    }
                  },
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// Empty Folder View Widget
class EmptyFolderView extends StatelessWidget {
  const EmptyFolderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Thư mục này trống.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5E6175),
            ),
          ),
        ),
      ),
    );
  }
}

// Add Options Dialog Widget
class AddOptionsDialog extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onCreateNew;
  final VoidCallback onAddExisting;

  const AddOptionsDialog({
    Key? key,
    required this.onClose,
    required this.onCreateNew,
    required this.onAddExisting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onClose,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: GestureDetector(
                onTap: () {}, // Prevent tap from bubbling up
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Thêm vào thư mục',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: onCreateNew,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              SizedBox(width: 10),
                              Text('Tạo mới'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text(
                        'Học phần',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.library_books,
                            color: Colors.blue,
                          ),
                        ),
                        title: const Text('ETS RC2 test 2'),
                        subtitle: const Text('Học phần • 95 thuật ngữ • Tá...'),
                        trailing: const Icon(Icons.add_circle_outline),
                        onTap: onAddExisting,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Folder Types Dialog Widget
class FolderTypesDialog extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSelectType;

  const FolderTypesDialog({
    Key? key,
    required this.onClose,
    required this.onSelectType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onClose,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {}, // Prevent tap from bubbling up
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(
                              Icons.library_books,
                              color: Colors.blue,
                            ),
                          ),
                          title: const Text('Học phần'),
                          onTap: onSelectType,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Options Bottom Sheet Widget
class OptionsBottomSheet extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  const OptionsBottomSheet({
    Key? key,
    required this.onEdit,
    required this.onShare,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.grey),
            title: const Text('Sửa'),
            onTap: onEdit,
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined, color: Colors.grey),
            title: const Text('Chia sẻ'),
            onTap: onShare,
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Xóa', style: TextStyle(color: Colors.red)),
            onTap: onDelete,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// Custom Bottom Navigation Bar Widget
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}

// Original FolderItem Widget (kept as is with safety checks)
class FolderDetailItem extends StatelessWidget {
  final GetAllSetsByFolderIdResponse item;

  const FolderDetailItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Icon(
            Icons.library_books,
            color: Colors.blue,
            size: 24,
          ),
        ),
        title: Text(
          item.setName ?? 'Không có tên',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              '${item.totalCards ?? 0} thuật ngữ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8),
            if (item.nameOwner != null) ...[
              const Text(' • '),
              Text(
                item.nameOwner!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
        onTap: () {
          // Handle tap action
        },
      ),
    );
  }
}