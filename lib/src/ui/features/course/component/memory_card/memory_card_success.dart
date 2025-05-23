import 'package:flutter/material.dart';

import '../../../../../../core/navigation/routers.dart';

class MemoryCardSuccess extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedAnswers;

  const MemoryCardSuccess({
    Key? key,
    this.totalQuestions = 18,
    this.correctAnswers = 18,
    this.wrongAnswers = 0,
    this.skippedAnswers = 0,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black54),
          onPressed: () {
            AppRouter.router.navigateTo(context, "/home");
          },
        ),
        title: Text(
          '$correctAnswers / $totalQuestions',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Progress indicator
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 1.0, // Full progress
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Main content
            Expanded(
              child: Column(
                children: [
                  // Title and illustration
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Chà, bạn năm bài thật chắc! Hãy thử chế độ Học để ôn luyện thêm.',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Illustration
                      Container(
                        width: 80,
                        height: 80,
                        child: Stack(
                          children: [
                            // Graduation cap
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 40,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4F46E5),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            // Decorative shapes
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF6B6B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4ECDC4),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            // More decorative elements
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFD93D),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  // Results section
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tiến độ của bạn',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Score circle and stats
                  Row(
                    children: [
                      // Score circle
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF4ECDC4),
                            width: 6,
                          ),
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check,
                            color: Color(0xFF4ECDC4),
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),

                      // Stats
                      Expanded(
                        child: Column(
                          children: [
                            _buildStatRow('Biết', correctAnswers, const Color(0xFF4ECDC4)),
                            const SizedBox(height: 8),
                            _buildStatRow('Đang học', wrongAnswers, const Color(0xFFFFB366)),
                            const SizedBox(height: 8),
                            _buildStatRow('Còn lại', skippedAnswers, const Color(0xFFE0E0E0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // // Back to questions button
                  // TextButton(
                  //   onPressed: () {
                  //     // Handle go back to questions
                  //   },
                  //   child: const Text(
                  //     'Quay lại câu hỏi cuối cùng',
                  //     style: TextStyle(
                  //       color: Color(0xFF4F46E5),
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                ],
              ),
            ),

            // Bottom buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle review in study mode
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Ôn luyện trong chế độ Học',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle reset reminder
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Đặt lại Thẻ ghi nhớ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color == const Color(0xFFE0E0E0) ? Colors.black54 : color,
            ),
          ),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color == const Color(0xFFE0E0E0) ? Colors.black54 : color,
            ),
          ),
        ],
      ),
    );
  }
}
