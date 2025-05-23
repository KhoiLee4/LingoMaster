import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

import '../../../../../../core/navigation/routers.dart';

class MatchingCardReady extends StatelessWidget {
  final String? id;
  const MatchingCardReady({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Color(0xFF465060),
            size: 30,
          ),
          onPressed: () {
            // Xử lý khi nhấn nút đóng
          },
        ),
        title: const Text(
          'Ghép thẻ',
          style: TextStyle(
            color: Color(0xFF465060),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.volume_up,
              color: Color(0xFF465060),
            ),
            onPressed: () {
              // Xử lý khi nhấn nút âm thanh
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Color(0xFF465060),
            ),
            onPressed: () {
              // Xử lý khi nhấn nút cài đặt
              AppRouter.router.navigateTo(context, "/matchingCardSetting", replace: true);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            const Text(
              'Bạn đã sẵn sàng?',
              style: TextStyle(
                color: Color(0xFF1E2939),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Ghép tất cả các thuật ngữ theo định nghĩa của chúng',
                style: TextStyle(
                  color: Color(0xFF1E2939),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý khi nhấn nút bắt đầu chơi
                  AppRouter.router.navigateTo(context, "/matchingCard/$id", replace: true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text(
                  'Bắt đầu chơi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
            // const NavigationBar(),
          ],
        ),
      ),
    );
  }
}

// class NavigationBar extends StatelessWidget {
//   const NavigationBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       decoration: const BoxDecoration(
//         border: Border(
//           top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.menu, color: Color(0xFF9E9E9E)),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.check_box_outline_blank, color: Color(0xFF9E9E9E)),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: Color(0xFF9E9E9E)),
//             onPressed: () {},
//           ),
//         ],
//       ),
//      );
//   }
// }
