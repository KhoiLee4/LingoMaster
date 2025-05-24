import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_master/core/data/NativeService/class_service.dart';
import 'package:lingo_master/core/data/NativeService/class_user_service.dart';
import 'package:lingo_master/core/domain/models/base-reponse.dart';
import 'package:lingo_master/core/domain/models/classroom_user.dart';
import 'package:lingo_master/core/domain/models/session.dart';
import 'package:lingo_master/src/ui/features/library/bloc/class/class_bloc.dart';
import 'package:lingo_master/src/ui/features/library/bloc/class/class_event.dart';
import 'package:lingo_master/src/ui/features/library/bloc/class/class_state.dart';
import '../../../../../../core/domain/dtos/classroom/classroom_dto.dart';
import '../../../../../../widgets/class_item.dart';

class ClasProvider extends StatelessWidget {
  const ClasProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClassBloc>(
      create: (context) {
        // Add debug info
        print('🚀 Creating ClassBloc...');
        print('📱 User session: ${Session.user != null ? "exists" : "null"}');
        if (Session.user != null) {
          print('👤 User ID: ${Session.user!.Id}');
        }
        
        final bloc = ClassBloc(ClassRoomUserService());
        // Trigger loading folders immediately after creating the bloc
        bloc.add(LoadClasses());
        return bloc;
      },
      child: ClassListSection(),
    );
  }
}

// Also update your ClassListSection to show more detailed error info
class ClassListSection extends StatelessWidget {
  const ClassListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassBloc, ClassState>(
      builder: (context, state) {
        print('🎭 Current state: ${state.runtimeType}');

        if (state is ClassLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Đang tải danh sách lớp học...'),
              ],
            ),
          );
        }

        else if (state is ClassLoaded) {
          print('📚 Classes loaded: ${state.classes?.length ?? 0} items');
          
          if (state.classes == null || state.classes!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Chưa tham gia lớp học nào',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Hãy tham gia hoặc tạo lớp học mới',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: state.classes!.length,
            itemBuilder: (context, index) {
              return ClassItem(item: state.classes![index], hasIcon: true,);
            },
          );
        }

        else if (state is ClassError) {
          print('❌ Class error: ${state.message}');
          
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  "Lỗi: ${state.message}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                // Add debug info in debug mode
                if (kDebugMode) ...[
                  Text(
                    "Debug Info:",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                  Text(
                    "User: ${Session.user != null ? 'Exists' : 'Null'}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  if (Session.user != null)
                    Text(
                      "User ID: ${Session.user!.Id ?? 'Null'}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                ],
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<ClassBloc>().add(LoadClasses());
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Thử lại'),
                ),
              ],
            ),
          );
        }

        else {
          // Initial state
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  
  }
  
}