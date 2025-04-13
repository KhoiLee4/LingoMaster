import 'package:flutter/material.dart';

class NewClassScreen extends StatefulWidget {
  const NewClassScreen({super.key});

  @override
  State<NewClassScreen> createState() => _NewClassScreenState();
}

class _NewClassScreenState extends State<NewClassScreen> {
  final _formKey = GlobalKey<FormState>();
  String _className = '';
  String _classDescription = '';
  bool _allowAdditions = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lớp mới'),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Save class information
                _formKey.currentState!.save();
                // Process data
                print('Class Name: $_className');
                print('Description: $_classDescription');
                print('Allow Additions: $_allowAdditions');
                // Navigate back or show success
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Lưu',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Class Name Field
              const Text(
                'Tên lớp',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nhập tên lớp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên lớp';
                  }
                  return null;
                },
                onSaved: (value) => _className = value!,
              ),
              const SizedBox(height: 24),

              // Class Description Field
              const Text(
                'Mô tả',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nhập mô tả lớp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                maxLines: 3,
                onSaved: (value) => _classDescription = value ?? '',
              ),
              const SizedBox(height: 24),

              // Permission Switch
              Row(
                children: [
                  Switch(
                    value: _allowAdditions,
                    onChanged: (value) {
                      setState(() {
                        _allowAdditions = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Cho phép thành viên lớp thêm học phần và thành viên mới',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}