import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';
import 'package:lingo_master/core/domain/models/session.dart';

import '../../../../../../core/navigation/routers.dart';

class MatchingCardResult extends StatefulWidget {
  final String time;
   MatchingCardResult({super.key, required this.time});

  @override
  State<MatchingCardResult> createState() => _MatchingCardResultState(time: time);
}

class _MatchingCardResultState extends State<MatchingCardResult> {
  bool showChallengeScreen = true;
  String time;
  _MatchingCardResultState({required this.time});
  void toggleScreen() {
    setState(() {
      showChallengeScreen = !showChallengeScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black54),
          onPressed: () {
            AppRouter.router.navigateTo(context, "/home");
          },
        ),
        title: const Text(
          'Ghép thẻ',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black54),
            onPressed: () {
              AppRouter.router.navigateTo(context, "/matchingCardSetting", replace: true);
            },
          ),
        ],
      ),
      body: showChallengeScreen ? ChallengeScreen(onTap: toggleScreen, time: time) : ResultScreen(onTap: toggleScreen, time: time,),
    );
  }
}

class ChallengeScreen extends StatelessWidget {
  final VoidCallback onTap;
  final String time;
  const ChallengeScreen({Key? key, required this.onTap, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Nhanh thật đấy!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Thách đấu bạn bè để xem họ vượt được điểm số của bạn không.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 30),
                // VS Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            'https://placedog.net/100/100',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          Session.user!.username ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          time,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'VS',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF666666),
                      ),
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: const Color(0xFFF2F2F7),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Bạn bè',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '- -',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Challenge Button
                ElevatedButton(
                  onPressed: (){},  // This will switch to the ResultScreen
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Thách đấu bạn bè',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Later Button
                TextButton(
                  onPressed: onTap,
                  child: const Text(
                    'Sau nhé',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4B6EFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Share Score Button
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFDDDDDD)),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share, color: Colors.grey[700]),
                  const SizedBox(width: 10),
                  Text(
                    'Chia sẻ điểm số của bạn',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ResultScreen extends StatelessWidget {
  final VoidCallback onTap;
  final String time;
  const ResultScreen({Key? key, required this.onTap,required this.time }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const Text(
                  'Mốc điểm cao mới!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Kỷ lục cá nhân mới!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 25),
                // Leaderboard Item
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          color: AppColors.primaryBlue,
                          alignment: Alignment.center,
                          child: const Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          time,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                            'https://placedog.net/100/100',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Session.user!.username ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Play Again Button
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              onPressed: onTap,  // This will switch back to the ChallengeScreen
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Chơi lại',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Share Score Button
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFDDDDDD)),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share, color: Colors.grey[700]),
                  const SizedBox(width: 10),
                  Text(
                    'Chia sẻ điểm số của bạn',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

