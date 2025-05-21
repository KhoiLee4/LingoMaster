import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

import '../../../../../core/navigation/routers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final List<String> searchSuggestions = [
    'study set',
    'study1716',
    'studyluke815',
    'study',
    'study aesthetics',
    'studygirlies',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: _isSearching
                  ? _buildSearchResults()
                  : _buildMainContent(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () {
              if (_isSearching) {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                });
              }
            },
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: _isSearching
                    ? 'study'
                    : 'Học phần, sách giáo khoa, câu hỏi',
                // border: InputBorder.none,
                filled: true, // Kích hoạt màu nền
                fillColor: AppColors.neutralGray100, // Màu nền bạn muốn
                hintStyle: TextStyle(
                  color: AppColors.neutralGray500,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onTap: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
          ),
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                _searchController.clear();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: searchSuggestions.length + 1,
      itemBuilder: (context, index) {
        if (index == searchSuggestions.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: TextButton(
                onPressed: () {
                  AppRouter.router.navigateTo(context, "/searchAll", replace: true);
                },
                child: const Text(
                  'Xem tất cả kết quả',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        }

        return ListTile(
          leading: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          title: Text(
            searchSuggestions[index],
            style: const TextStyle(fontSize: 16),
          ),
          onTap: () {},
        );
      },
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        const SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                'Nhập một chủ đề hoặc từ khóa',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.neutralGray600,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Mẹo: Càng cụ thể càng tốt!',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.neutralGray600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // const Spacer(),
        // _buildQuizletOption(),
      ],
    );
  }

  // Widget _buildQuizletOption() {
  //   return Container(
  //     margin: const EdgeInsets.all(16),
  //     padding: const EdgeInsets.symmetric(vertical: 16),
  //     decoration: BoxDecoration(
  //       color: Colors.blue.shade100,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const Text(
  //           'Chơi Quizlet Live hoặc Cột mốc',
  //           style: TextStyle(
  //             fontSize: 17,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //         const SizedBox(width: 12),
  //         _buildAvatarIndicator(Colors.purple),
  //         _buildAvatarIndicator(Colors.blue),
  //         _buildAvatarIndicator(Colors.orange),
  //         _buildAvatarIndicator(Colors.yellow),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildAvatarIndicator(Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
    );
  }
}
