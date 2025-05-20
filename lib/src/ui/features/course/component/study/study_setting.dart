import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

import '../../../../../../core/navigation/routers.dart';

class StudySetting extends StatefulWidget {
  const StudySetting({super.key});

  @override
  State<StudySetting> createState() => _StudySettingState();
}

class _StudySettingState extends State<StudySetting> {
  // Toggle states
  bool fullScreenMode = true;
  bool soundEnabled = true;
  bool reloadCorrectAnswer = true;
  bool englishLanguage = true;
  bool vietnameseLanguage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            AppRouter.router.navigateTo(context, "/study", replace: true);
          }
        ),
        title: const Text(
          'Tùy chọn',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // GENERAL SECTION
              const Text(
                'CHUNG',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              // Full screen mode toggle
              _buildToggleOption(
                title: 'Trộn thẻ',
                value: fullScreenMode,
                onChanged: (value) {
                  setState(() {
                    fullScreenMode = value;
                  });
                },
              ),

              // Sound toggle
              _buildToggleOption(
                title: 'Âm thanh',
                value: soundEnabled,
                onChanged: (value) {
                  setState(() {
                    soundEnabled = value;
                  });
                },
              ),

              // Reload correct answer toggle
              _buildToggleOption(
                title: 'Nhập lại câu trả lời đúng',
                value: reloadCorrectAnswer,
                onChanged: (value) {
                  setState(() {
                    reloadCorrectAnswer = value;
                  });
                },
              ),

              const SizedBox(height: 32),

              // ANSWER BY SECTION
              const Text(
                'TRẢ LỜI BẰNG',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              // English language toggle
              _buildToggleOption(
                title: 'Tiếng Anh',
                value: englishLanguage,
                onChanged: (value) {
                  setState(() {
                    englishLanguage = value;
                  });
                },
                activeColor: AppColors.primaryBlue,
              ),

              // Vietnamese language toggle
              _buildToggleOption(
                title: 'Tiếng Việt',
                value: vietnameseLanguage,
                onChanged: (value) {
                  setState(() {
                    vietnameseLanguage = value;
                  });
                },
                activeColor: AppColors.primaryBlue,
              ),

              const SizedBox(height: 32),

              // QUESTION TYPE SECTION
              const Text(
                'LOẠI CÂU HỎI',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              // Learning mode explanation
              const Text(
                'Chế độ Học dựa trên nền tảng khoa học học tập, do đó các loại câu hỏi mà bạn thấy sẽ thích ứng theo mục tiêu của bạn. Việc tự tùy chỉnh các loại câu hỏi sẽ tắt tính năng học thích ứng.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),

              // Custom question type button
              GestureDetector(
                onTap: () {
                  // Handle custom question type selection
                },
                child: const Text(
                  'Chọn loại câu hỏi của riêng bạn',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Open self-reasoning mode
              GestureDetector(
                onTap: () {
                  // Handle opening self-reasoning mode
                },
                child: const Text(
                  'Mở chế độ Tự luận tại đây',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Write button
              SizedBox(
                width: 120,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
                  label: const Text(
                    'Viết',
                    style: TextStyle(
                      color: AppColors.neutralGray900,
                      fontSize: 16,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // Handle write button tap
                  },
                ),
              ),

              // Second image additional content
              const SizedBox(height: 24),

              // Correction options (from second image)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tùy chọn sửa sai\nChấm điểm thông minh',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // OTHER SECTION
              const Text(
                'KHÁC',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),

              // Re-enable learning mode
              GestureDetector(
                onTap: () {
                  // Handle re-enabling learning mode
                },
                child: const Text(
                  'Bật lại chế độ Học',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

    );
  }
}
Widget _buildToggleOption({
  required String title,
  required bool value,
  required ValueChanged<bool> onChanged,
  Color activeColor = AppColors.primaryBlue,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.neutralGray900,
            fontWeight: FontWeight.bold
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: activeColor,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    ),
  );
}

