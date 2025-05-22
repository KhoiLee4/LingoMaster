import 'package:flutter/material.dart';

import '../../../../core/data/NativeService/folder_service.dart';
import '../../../../core/data/NativeService/folder_user_service.dart';

class TesttScreen extends StatefulWidget {
  const TesttScreen({super.key});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TesttScreen> {

  void test() async {

  }

  @override
  Widget build(BuildContext context) {
    test();
    return Scaffold(
      body: Center(
        child: Text('Khoi'),
      ),
    );
  }
}
