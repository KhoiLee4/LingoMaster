import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

import '../../../../../../core/navigation/routers.dart';

class MatchingCardSetting extends StatefulWidget {
  const MatchingCardSetting({super.key});

  @override
  State<MatchingCardSetting> createState() => _MatchingCardSettingState();
}

class _MatchingCardSettingState extends State<MatchingCardSetting> {
  bool thuatNguEnabled = true;
  bool dinhNghiaEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54, size: 28),
          onPressed: () {
            AppRouter.router.navigateTo(context, "/home", replace: true);
          },
        ),
        title: const Text(
          'Tùy chọn',
          style: TextStyle(
            color: Color(0xFF6A7185),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // GHÉP THẺ section header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'GHÉP THẺ',
              style: TextStyle(
                color: Color(0xFF6A7185),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Thuật ngữ switch
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Thuật ngữ',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: thuatNguEnabled,
                  onChanged: (value) {
                    setState(() {
                      thuatNguEnabled = value;
                    });
                  },
                  activeTrackColor: const Color(0xFFD4DDFF),
                  activeColor: const Color(0xFF4B6EFF),
                ),
              ],
            ),
          ),

          const Divider(
            height: 1,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Color(0xFFF3F3F3),
          ),

          // Định nghĩa switch
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Định nghĩa',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: dinhNghiaEnabled,
                  onChanged: (value) {
                    setState(() {
                      dinhNghiaEnabled = value;
                    });
                  },
                  activeTrackColor: const Color(0xFFD4DDFF),
                  activeColor: const Color(0xFF4B6EFF),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Description text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Bạn sẽ được đặt câu hỏi để nhớ lại thuật ngữ và định nghĩa',
              style: TextStyle(
                color: Color(0xFF6A7185),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Reset button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Bắt lại Ghép thẻ',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
