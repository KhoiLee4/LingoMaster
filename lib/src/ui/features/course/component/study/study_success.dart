import 'package:flutter/material.dart';

import '../../../../../../core/navigation/routers.dart';

class StudySuccess extends StatefulWidget {
  const StudySuccess({Key? key}) : super(key: key);

  @override
  State<StudySuccess> createState() => _StudySuccessState();
}

class _StudySuccessState extends State<StudySuccess> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey, size: 28),
                    onPressed: () {
                      AppRouter.router.navigateTo(context, "/home");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.grey, size: 28),
                    onPressed: () {
                      // Handle settings
                    },
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Title
                    const Text(
                      'Mạnh mẽ lên, bạn có thể thành công.',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Progress Section
                    Row(
                      children: [
                        // Left progress circle
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6FFFA),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              '7',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00A693),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Progress bar
                        Expanded(
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: LinearProgressIndicator(
                              value: 7 / 25, // 7 out of 25 total
                              backgroundColor: const Color(0xFFE2E8F0),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF00A693),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Right progress circle
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7FAFC),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              '18',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF718096),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Progress labels
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Đúng',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF718096),
                          ),
                        ),
                        Text(
                          'Tổng số câu hỏi',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF718096),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle continue to round 2
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Quay lại',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VocabularyCard extends StatelessWidget {
  final VocabularyItem item;
  final VoidCallback onStarTap;

  const VocabularyCard({
    Key? key,
    required this.item,
    required this.onStarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.english,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.volume_up_outlined, size: 24),
                color: Colors.grey[600],
                onPressed: () {
                  // Handle audio play
                },
              ),
              IconButton(
                icon: Icon(
                  item.isStarred ? Icons.star : Icons.star_border,
                  size: 24,
                ),
                color: item.isStarred ? Colors.amber : Colors.grey[600],
                onPressed: onStarTap,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.vietnamese,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

class VocabularyItem {
  final String english;
  final String vietnamese;
  bool isStarred;

  VocabularyItem({
    required this.english,
    required this.vietnamese,
    required this.isStarred,
  });
}