import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/NativeService/class_folder_service.dart';
import '../../../../../core/data/NativeService/class_service.dart';
import '../../../../../core/data/NativeService/class_set_service.dart';
import '../../../../../core/design_systems/theme/app_colors.dart';
import '../../../../../core/domain/dtos/classroom_user/get_all_set_by_classroom_id_respone.dart';
import '../../../../../core/navigation/routers.dart';
import '../bloc/class_bloc.dart';
import '../bloc/class_event.dart';
import '../bloc/class_state.dart';

class ClassProvider extends StatelessWidget {
  final String? id;

  const ClassProvider({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClassBloc>(
      create: (context) {
        final bloc = ClassBloc(ClassRoomService(), ClassroomSetService(), ClassroomFolderService(), id!);
        bloc.add(LoadClasses());
        return bloc;
      },
      child: ClassScreen(id: id),
    );
  }
}

class ClassScreen extends StatefulWidget {
  final String? id;

  const ClassScreen({super.key, required this.id});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String className = "kkkk";
  bool isMenuOpen = false;
  bool hasLessons = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: ClassAppBar(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClassHeader(),
              ClassTabBar(tabController: _tabController),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LessonsTab(),
                    MembersTabContent(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LessonsTab extends StatelessWidget {
  const LessonsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassBloc, ClassState>(
      builder: (context, state) {
        if (state is ClassLoading) {
          return const ClassLoadingWidget();
        } else if (state is ClassLoaded) {
          if (state.courses == null || state.courses!.isEmpty) {
            return const EmptyLessonsContent();
          }
          return LessonsTabContent();
        } else if (state is ClassError) {
          return ClassErrorWidget(state: state);
        } else {
          return const ClassLoadingWidget();
        }
      },
    );
  }
}


// Separate AppBar Widget
class ClassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClassAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryWhite,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Lớp'),
      actions: [
        ClassPopupMenu(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Separate Popup Menu Widget
class ClassPopupMenu extends StatelessWidget {
  const ClassPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        _handleMenuSelection(value);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'invite',
          child: Text('Mời thành viên'),
        ),
        PopupMenuItem(
          value: 'add_course',
          child: Text('Thêm học phần'),
        ),
        PopupMenuItem(
          value: 'add_folder',
          child: Text('Thêm thư mục'),
        ),
        PopupMenuItem(
          value: 'report',
          child: Text('Báo cáo'),
        ),
        PopupMenuItem(
          value: 'leave_class',
          child: Text('Bỏ lớp học'),
        ),
      ],
    );
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'invite':
        print("Mời thành viên");
        break;
      case 'add_course':
        print("Thêm học phần");
        break;
      case 'add_folder':
        print("Thêm thư mục");
        break;
      case 'report':
        print("Báo cáo");
        break;
      case 'leave_class':
        print("Bỏ lớp học");
        break;
    }
  }
}

// Separate Class Header Widget
class ClassHeader extends StatelessWidget {
  const ClassHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassBloc, ClassState>(
      builder: (context, state) {
        if (state is ClassLoading) {
          return const ClassLoadingWidget();
        } else if (state is ClassLoaded) {
          if (state.classs == null) {
            return const ClassEmptyWidget();
          }
          return ClassLoadedWidget(state: state);
        } else if (state is ClassError) {
          return ClassErrorWidget(state: state);
        } else {
          return const ClassLoadingWidget();
        }
      },
    );
  }
}

// Class Loading Widget
class ClassLoadingWidget extends StatelessWidget {
  const ClassLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

// Class Empty Widget
class ClassEmptyWidget extends StatelessWidget {
  const ClassEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Chưa có lớp nào',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

// Class Loaded Widget
class ClassLoadedWidget extends StatelessWidget {
  final ClassLoaded state;

  const ClassLoadedWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.classs.name,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Class Error Widget
class ClassErrorWidget extends StatelessWidget {
  final ClassError state;

  const ClassErrorWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Lỗi: ${state.message}"),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              if (context.mounted) {
                context.read<ClassBloc>().add(LoadClasses());
              }
            },
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}

// Separate Tab Bar Widget
class ClassTabBar extends StatelessWidget {
  final TabController tabController;

  const ClassTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.blue,
      indicatorWeight: 3,
      tabs: const [
        Tab(text: 'HỌC PHẦN'),
        Tab(text: 'THÀNH VIÊN'),
      ],
    );
  }
}

// Empty Lessons Content Widget
class EmptyLessonsContent extends StatelessWidget {
  const EmptyLessonsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Lớp học này không có học phần nào',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        const Text(
          'Thêm học phần để chia sẻ với lớp của bạn.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            // Handle add lesson
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text(
            'Thêm học phần',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

// Lessons Tab Content Widget
class LessonsTabContent extends StatelessWidget {
  const LessonsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LessonsTimeLabel(),
        LessonCard(),
      ],
    );
  }
}

// Lessons Time Label Widget
class LessonsTimeLabel extends StatelessWidget {
  const LessonsTimeLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        'ÍT GIÂY TRƯỚC',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Lesson Card Widget
class LessonCard extends StatelessWidget {
  const LessonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassBloc, ClassState>(
      builder: (context, state) {
        if (state is ClassLoading) {
          return const ClassLoadingWidget();
        } else if (state is ClassLoaded) {
          if (state.courses == null || state.courses!.isEmpty) {
            return const ClassEmptyWidget();
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.courses?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (index < (state.courses?.length ?? 0)) {
                        return CourseClassItem(item: state.courses![index]);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is ClassError) {
          return ClassErrorWidget(state: state);
        } else {
          return const ClassLoadingWidget();
        }
      },
    );
  }
}

// Lesson Card Title Widget
class LessonCardTitle extends StatelessWidget {
  const LessonCardTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Meetings',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// Lesson Card Subtitle Widget
class LessonCardSubtitle extends StatelessWidget {
  const LessonCardSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '7 thuật ngữ',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
    );
  }
}

// Lesson Card Author Widget
class LessonCardAuthor extends StatelessWidget {
  const LessonCardAuthor({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          radius: 16,
        ),
        const SizedBox(width: 8),
        const Text(
          'KNgao1',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// Members Tab Content Widget
class MembersTabContent extends StatelessWidget {
  const MembersTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MemberListItem(),
      ],
    );
  }
}

// Member List Item Widget
class MemberListItem extends StatelessWidget {
  const MemberListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
        radius: 20,
      ),
      title: const Text('KhoiLee04'),
    );
  }
}

class CourseClassItem extends StatelessWidget {
  final GetAllSetByClassroomIdRespone item;

  const CourseClassItem({super.key,  required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          AppRouter.router.navigateTo(context, "/coursepage/${item.idSet}");
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.nameSet,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${item.totalCard} thuật ngữ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        '👤',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    item.nameUser,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
