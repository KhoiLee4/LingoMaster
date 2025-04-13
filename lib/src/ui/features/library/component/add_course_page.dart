import 'package:flutter/material.dart';

class NewcourseScreen extends StatefulWidget {
  const NewcourseScreen({super.key});

  @override
  State<NewcourseScreen> createState() => _NewcourseScreenState();
}

class _NewcourseScreenState extends State<NewcourseScreen> {
  final List<Map<String, TextEditingController>> _flashcards = [
    {
      'term': TextEditingController(),
      'definition': TextEditingController(),
    },
    {
      'term': TextEditingController(),
      'definition': TextEditingController(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.grey),
        onPressed: () {},
      ),
      title: const Text(
        'Tạo học phần',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.grey),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.check, color: Colors.grey),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection(),
          const SizedBox(height: 8),
          ..._buildFlashcards(),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Chủ đề, chương, đơn vị',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: InputBorder.none,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo, width: 2),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'TIÊU ĐỀ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.document_scanner, color: Colors.blue[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Quét tài liệu',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.lock, color: Colors.black87),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, color: Colors.blue),
                label: Text(
                  'Mô tả',
                  style: TextStyle(color: Colors.blue[600]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFlashcards() {
    List<Widget> cards = [];
    for (int i = 0; i < _flashcards.length; i++) {
      cards.add(_buildFlashcardItem(i + 1, _flashcards[i]));
    }
    return cards;
  }

  Widget _buildFlashcardItem(int index, Map<String, TextEditingController> controllers) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controllers['term'],
            decoration: const InputDecoration(
              hintText: '',
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'THUẬT NGỮ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllers['definition'],
            decoration: const InputDecoration(
              hintText: '',
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'ĐỊNH NGHĨA',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          _flashcards.add({
            'term': TextEditingController(),
            'definition': TextEditingController(),
          });
        });
      },
      backgroundColor: Colors.blue[600],
      child: const Icon(Icons.add, color: Colors.white, size: 32),
    );
  }
}