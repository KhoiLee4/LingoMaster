import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

import '../../../../../core/navigation/routers.dart';

class SearchALLScreen extends StatefulWidget {
  const SearchALLScreen({super.key});

  @override
  State<SearchALLScreen> createState() => _SearchALLScreenState();
}

class _SearchALLScreenState extends State<SearchALLScreen> with TickerProviderStateMixin{
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController(text: "study");
  bool _hasResults = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: AppColors.primaryWhite,
          leadingWidth: 40,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () {
              AppRouter.router.navigateTo(context, "/search", replace: true);
            },
          ),
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                contentPadding: const EdgeInsets.only(bottom: 10, left: 15),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: AppColors.neutralGray900,
            unselectedLabelColor: AppColors.neutralGray600,
            tabs: const [
              Tab(text: "Tất cả kết quả"),
              Tab(text: "Học phần"),
              Tab(text: "Sách giáo khoa"),
              Tab(text: "Câu hỏi"),
              Tab(text: "Người dùng"),
              Tab(text: "Lớp học"),
            ],
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: AppColors.primaryBlue,),
              insets: EdgeInsets.symmetric(horizontal: 0.0),
            ),
          ),
          Expanded(
            child: _hasResults
                ? TabBarView(
              controller: _tabController,
              children: [
                _buildAllResultsTab(),
                _buildCoursesTab(),
                _buildTextbooksTab(),
                _buildQuestionsTab(),
                _buildUsersTab(),
                _buildClassesTab(),
              ],
            )
                : const Center(
              child: Text(
                "Không có kết quả cho tìm kiếm của bạn, vui lòng thử lại",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildAllResultsTab() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildSectionHeader("Học phần", 1),
        _buildStudyItem(
          title: "Study",
          subtitle: "141 thuật ngữ",
          username: "Alizandro_Venom",
          activeUsers: "15 người học hôm nay",
          hasPreview: false,
        ),
        _buildStudyItem(
          title: "Social Studies",
          subtitle: "32 thuật ngữ",
          username: "nmsylvester",
          activeUsers: "25 người học hôm nay",
          hasPreview: false,
        ),
        _buildStudyItem(
          title: "study",
          subtitle: "9 thuật ngữ",
          username: "Sahil_Safi",
          activeUsers: "24 người học hôm nay",
          hasPreview: false,
          isPlus: true,
        ),

        const SizedBox(height: 15),
        _buildSectionHeader("Người dùng", 4),
        _buildUserItem(
          username: "Stmudy",
          coursesCount: "6",
          classesCount: "0",
        ),
        _buildUserItem(
          username: "stndy",
          coursesCount: "0",
          classesCount: "0",
          profileImagePath: "assets/blue_bear.png",
        ),

        const SizedBox(height: 15),
        _buildSectionHeader("Câu hỏi", 3),
        _buildQuestionItem(
          subject: "Khoa học máy tính",
          question: "Write C++ statements that declare the following variables: name of type string and studyHours of type double.Write C++ statements that prompt and input a string into name and a double value into",
          verified: true,
        ),
        _buildQuestionItem(
          subject: "Tiếng Anh",
          question: "It is a part of the research paper which identifies the benefactors of the study and how they will be benefitted. a. introduction b. definition of terms c. significance of the studyd. delimitation of the study",
          verified: true,
        ),

        const SizedBox(height: 15),
        _buildSectionHeader("Sách giáo khoa", 2),
        _buildTextbookItem(
          title: "Chemistry: Guided Reading and Study Workbook",
          publisher: "Prentice Hall",
          answersCount: "1.374",
        ),
        _buildTextbookItem(
          title: "Biology Study Workbook A",
          publisher: "Kenneth R. Miller, Levine",
          subtitle: "1st Edition",
          answersCount: "2.868",
        ),

        const SizedBox(height: 15),
        _buildSectionHeader("Lớp học", 5),
        _buildClassItem(
          className: "Study",
          school: "VLU",
          location: "Ho Chi Minh City, Ho Chi Minh City",
          partsCount: "7",
          membersCount: "1",
        ),
        _buildClassItem(
          className: "Study!",
          school: "University of Social Sciences & Humanities",
          location: "Ho Chi Minh City, Ho Chi Minh City",
          partsCount: "10",
          membersCount: "5",
        ),
      ],
    );
  }

  Widget _buildCoursesTab() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildFilterButton(),
        _buildStudyItem(
          title: "Study",
          subtitle: "141 thuật ngữ",
          username: "Alizandro_Venom",
          activeUsers: "15 người học hôm nay",
          hasPreview: true,
        ),
        _buildStudyItem(
          title: "Social Studies",
          subtitle: "32 thuật ngữ",
          username: "nmsylvester",
          activeUsers: "25 người học hôm nay",
          hasPreview: true,
        ),
        _buildStudyItem(
          title: "study",
          subtitle: "9 thuật ngữ",
          username: "Sahil_Safi",
          activeUsers: "24 người học hôm nay",
          hasPreview: true,
          isPlus: true,
        ),
      ],
    );
  }

  Widget _buildTextbooksTab() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildTextbookItem(
          title: "Chemistry: Guided Reading and Study Workbook",
          publisher: "Prentice Hall",
          answersCount: "1.374",
        ),
        _buildTextbookItem(
          title: "Biology Study Workbook B",
          publisher: "Savvas Learning Co",
          subtitle: "1st Edition",
          answersCount: "2.160",
        ),
        _buildTextbookItem(
          title: "Biology Study Workbook A",
          publisher: "Kenneth R. Miller, Levine",
          subtitle: "1st Edition",
          answersCount: "2.868",
        ),
      ],
    );
  }

  Widget _buildQuestionsTab() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildQuestionItem(
          subject: "Khoa học máy tính",
          question: "Write C++ statements that declare the following variables: name of type string and studyHours of type double.Write C++ statements that prompt and input a string into name and a double value into",
          verified: true,
        ),
        _buildQuestionItem(
          subject: "Tiếng Anh",
          question: "It is a part of the research paper which identifies the benefactors of the study and how they will be benefitted. a. introduction b. definition of terms c. significance of the studyd. delimitation of the study",
          verified: true,
        ),
        _buildQuestionItem(
          subject: "Sức khỏe",
          question: "What is an ureterpyelogram?A. A radiographic study of the renal pelvis and ureterB. A test for transplant compatibilityC. An abdominal computed tomographic studyD. A radiographic study of the",
          verified: true,
        ),
      ],
    );
  }

  Widget _buildUsersTab() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildUserItem(
          username: "Stmudy",
          coursesCount: "6",
          classesCount: "0",
        ),
        _buildUserItem(
          username: "stndy",
          coursesCount: "0",
          classesCount: "0",
          profileImagePath: "assets/blue_bear.png",
        ),
        _buildUserItem(
          username: "Stfudy",
          coursesCount: "0",
          classesCount: "0",
        ),
        _buildUserItem(
          username: "Steudy",
          coursesCount: "0",
          classesCount: "0",
        ),
      ],
    );
  }

  Widget _buildClassesTab() {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(15),
          children: [
            _buildClassItem(
              className: "Study",
              school: "VLU",
              location: "Ho Chi Minh City, Ho Chi Minh City",
              partsCount: "7",
              membersCount: "1",
            ),
            _buildClassItem(
              className: "Study!",
              school: "University of Social Sciences & Humanities",
              location: "Ho Chi Minh City, Ho Chi Minh City",
              partsCount: "10",
              membersCount: "5",
            ),
            _buildClassItem(
              className: "study",
              school: "Saigon South International School",
              location: "Ho Chi Minh City, Ho Chi Minh City",
              partsCount: "0",
              membersCount: "1",
            ),
            const SizedBox(height: 80), // For ad space
          ],
        ),

      ],
    );
  }

  Widget _buildSectionHeader(String title, int tabIndex) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              _tabController.animateTo(tabIndex);
            },
            child: const Text(
              "Xem tất cả",
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 14,
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.filter_list, size: 18),
        label: const Text("Bộ lọc"),
        style: TextButton.styleFrom(
          foregroundColor: Colors.black54,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildStudyItem({
    required String title,
    required String subtitle,
    required String username,
    required String activeUsers,
    bool hasPreview = false,
    bool isPlus = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.neutralGray100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.trending_up, color: Colors.red, size: 14),
                  const SizedBox(width: 5),
                  Text(
                    activeUsers,
                    style: const TextStyle(fontSize: 12, color: AppColors.neutralGray800, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor:
                  username == "Alizandro_Venom" ? Colors.pink :
                  username == "nmsylvester" ? Colors.amber :
                  Colors.orange,
                  child: const Text("👤", style: TextStyle(fontSize: 12)),
                ),
                const SizedBox(width: 10),
                Text(
                  username,
                  style: const TextStyle(fontSize: 14),
                ),
                if (isPlus)
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Plus",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                const Spacer(),
                if (hasPreview)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "Preview",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextbookItem({
    required String title,
    required String publisher,
    String? subtitle,
    required String answersCount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 70,
              decoration: BoxDecoration(
                color: title.contains("Chemistry") ? Colors.red : Colors.amber,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: title.contains("Chemistry")
                    ? const Text("Chemistry", style: TextStyle(color: Colors.white, fontSize: 10))
                    : const Text("Biology", style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      publisher,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle, color: Colors.blue, size: 14),
                        const SizedBox(width: 5),
                        Text(
                          "$answersCount lời giải",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionItem({
    required String subject,
    required String question,
    required bool verified,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              question,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.blue, size: 14),
                  const SizedBox(width: 5),
                  const Text(
                    "Lời giải đã xác minh",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserItem({
    required String username,
    required String coursesCount,
    required String classesCount,
    String? profileImagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: profileImagePath != null ? AssetImage(profileImagePath) : null,
              child: profileImagePath == null ? const Icon(Icons.person, color: Colors.grey) : null,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "$coursesCount học phần • $classesCount lớp học",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassItem({
    required String className,
    required String school,
    required String location,
    required String partsCount,
    required String membersCount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              className,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  school,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  " • ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Expanded(
                  child: Text(
                    location,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.book_outlined, size: 14),
                      const SizedBox(width: 5),
                      Text("$partsCount học phần"),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person_outline, size: 14),
                      const SizedBox(width: 5),
                      Text("$membersCount thành viên"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
