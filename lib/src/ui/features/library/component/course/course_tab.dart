import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import for date formatting

import 'package:lingo_master/core/data/NativeService/set_user_service.dart';
import 'package:lingo_master/core/domain/dtos/classroom/classroom_dto.dart';
import 'package:lingo_master/core/domain/dtos/set_user/created_set_dto.dart';
import 'package:lingo_master/core/domain/models/base-reponse.dart';
import 'package:lingo_master/core/domain/models/session.dart';
import 'package:lingo_master/src/ui/features/home/bloc/folder/folder_event.dart';
import 'package:lingo_master/src/ui/features/library/bloc/course/course_bloc.dart';
import 'package:lingo_master/src/ui/features/library/bloc/course/course_event.dart';
import 'package:lingo_master/src/ui/features/library/bloc/course/course_state.dart';

import '../../../../../../core/domain/dtos/set/set_dto.dart';
import '../../../../../../widgets/course_item.dart';

class CourseProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Add debug info
        print('🚀 Creating ClassBloc...');
        print('📱 User session: ${Session.user != null ? "exists" : "null"}');
        if (Session.user != null) {
          print('👤 User ID: ${Session.user!.Id}');
        }

        final bloc = LibCourseBloc(SetUserService());
        // Trigger loading folders immediately after creating the bloc
        bloc.add(LibLoadCourse());
        return bloc;
      },
      child: CourseTab(selectedFilter: 'Tất cả'),
    );
  }
}

class CourseTab extends StatelessWidget {
  final String selectedFilter;

  const CourseTab({Key? key, required this.selectedFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibCourseBloc, LibCourseState>(
      builder: (context, state) {
        print('🎭 Current state: ${state.runtimeType}');

        if (state is LibCourseLoading) {
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
        } else if (state is LibCourseLoaded) {
          if (state.sets == null || state.sets!.isEmpty) {
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

          // Group sets by date
          final Map<String, List<CreatedSetDto>> groupedSets = {};
          for (var set in state.sets!) {
            // Format the date to a string (e.g., "yyyy-MM-dd") for grouping
            final dateKey =
                DateFormat('dd/MM/yyyy').format(set.createdAt!); // Use ! for non-nullable
            if (!groupedSets.containsKey(dateKey)) {
              groupedSets[dateKey] = [];
            }
            groupedSets[dateKey]!.add(set);
          }

          // Convert grouped sets to a list of entries for consistent ordering
          final List<MapEntry<String, List<CreatedSetDto>>> sortedGroupedSets =
              groupedSets.entries.toList()
                ..sort((a, b) => DateFormat('dd/MM/yyyy')
                    .parse(b.key)
                    .compareTo(DateFormat('dd/MM/yyyy').parse(a.key))); // Sort by date descending

          return Container(
            color: Colors.grey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filter Section (remains the same)
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Bộ lọc',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                // Library Items
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: sortedGroupedSets.length,
                    itemBuilder: (context, groupIndex) {
                      final entry = sortedGroupedSets[groupIndex];
                      final date = entry.key;
                      final setsForDate = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(height: 1, color: Colors.grey[300]),
                          // Date Section
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              date,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          // List of CourseItems for this date
                          ListView.builder(
                            shrinkWrap: true, // Important for nested ListView
                            physics:
                                NeverScrollableScrollPhysics(), // Disable scrolling for nested list
                            itemCount: setsForDate.length,
                            itemBuilder: (context, setIndex) {
                              return CourseItem(item: setsForDate[setIndex]);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is LibCourseError) {
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
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
                    context.read<LibCourseBloc>().add(LibLoadCourse());
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Thử lại'),
                ),
              ],
            ),
          );
        } else {
          // Initial state
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}