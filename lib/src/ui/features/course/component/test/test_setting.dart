import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

import '../../../../../../core/navigation/routers.dart';

class TestSetting extends StatefulWidget {
  final String? id;
  const TestSetting({super.key, this.id});

  @override
  State<TestSetting> createState() => _TestSettingState();
}

class _TestSettingState extends State<TestSetting> {
  bool showAnswersImmediately = false;
  bool showCorrectIncorrect = false;
  bool multipleChoice = true;
  bool essay = false;
  int questionCount = 20;
  int maxQuestionCount = 95;
  String title = "ETS RC2 test 2";
  TextEditingController questionCountController = TextEditingController(text: "20");

  bool englishAnswerOption = true;
  bool vietnameseAnswerOption = true;
  bool englishQuestionOption = true;
  bool vietnameseQuestionOption = true;

  String answerLanguagesText = "Tiếng Anh, Tiếng Việt";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.grey[700], size: 30),
          onPressed: () {
            // Close action
            AppRouter.router.navigateTo(context, "/home");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Thiết lập bài kiểm tra",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.check_box_outlined,
                    color: Colors.orange[400],
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Số câu hỏi ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "(tối đa $maxQuestionCount)",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 30,
                  alignment: Alignment.centerRight,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none, // hoặc OutlineInputBorder nếu bạn muốn có viền
                      isDense: true, // thu gọn khoảng trống
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      // Xử lý khi người dùng nhập số, ví dụ:
                      final number = int.tryParse(value);
                      if (number != null) {
                        setState(() {
                          questionCount = number;
                        });
                      }
                    },
                  ),
                ),

              ],
            ),
            const SizedBox(height: 20),
            SettingToggle(
              title: "Hiển thị đáp án ngay",
              value: showAnswersImmediately,
              onChanged: (value) {
                setState(() {
                  showAnswersImmediately = value;
                });
              },
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                _showLanguageOptions(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Trả lời bằng: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: answerLanguagesText,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 10),
            SettingToggle(
              title: "Đúng / Sai",
              value: showCorrectIncorrect,
              onChanged: (value) {
                setState(() {
                  showCorrectIncorrect = value;
                });
              },
            ),
            const SizedBox(height: 10),
            SettingToggle(
              title: "Nhiều lựa chọn",
              value: multipleChoice,
              onChanged: (value) {
                setState(() {
                  multipleChoice = value;
                });
              },
            ),
            const SizedBox(height: 10),
            SettingToggle(
              title: "Tự luận",
              value: essay,
              onChanged: (value) {
                setState(() {
                  essay = value;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Start the test action
                  AppRouter.router.navigateTo(context, "/test/${widget.id}", replace: true);
                },
                child: const Text(
                  "Bắt đầu làm kiểm tra",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),

    );
  }

  void _showLanguageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              // Ensure there's enough height for the content
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: SizedBox(
                      width: 40,
                      child: Divider(thickness: 4, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Tùy chọn câu trả lời",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Trả lời bằng",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SettingToggle(
                    title: "Tiếng Anh",
                    value: englishAnswerOption,
                    onChanged: (value) {
                      setModalState(() {
                        englishAnswerOption = value;
                      });
                      setState(() {
                        englishAnswerOption = value;
                        _updateLanguageText();
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  SettingToggle(
                    title: "Tiếng Việt",
                    value: vietnameseAnswerOption,
                    onChanged: (value) {
                      setModalState(() {
                        vietnameseAnswerOption = value;
                      });
                      setState(() {
                        vietnameseAnswerOption = value;
                        _updateLanguageText();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Hỏi bằng",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SettingToggle(
                    title: "Tiếng Anh",
                    value: englishQuestionOption,
                    onChanged: (value) {
                      setModalState(() {
                        englishQuestionOption = value;
                      });
                      setState(() {
                        englishQuestionOption = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  SettingToggle(
                    title: "Tiếng Việt",
                    value: vietnameseQuestionOption,
                    onChanged: (value) {
                      setModalState(() {
                        vietnameseQuestionOption = value;
                      });
                      setState(() {
                        vietnameseQuestionOption = value;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  void _updateLanguageText() {
    List<String> languages = [];
    if (englishAnswerOption) languages.add("Tiếng Anh");
    if (vietnameseAnswerOption) languages.add("Tiếng Việt");

    setState(() {
      answerLanguagesText = languages.join(", ");
    });
  }
}

class SettingToggle extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingToggle({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryWhite,
            activeTrackColor: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }
}

// Add a number input widgets for question count
class NumberInputField extends StatefulWidget {
  final int value;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const NumberInputField({
    Key? key,
    required this.value,
    required this.maxValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NumberInputField> createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      ),
      onChanged: (value) {
        int? newValue = int.tryParse(value);
        if (newValue != null) {
          if (newValue > widget.maxValue) {
            newValue = widget.maxValue;
            _controller.text = widget.maxValue.toString();
          }
          widget.onChanged(newValue);
        }
      },
    );
  }
}

//
// class SettingToggle extends StatelessWidget {
//   final String title;
//   final bool value;
//   final ValueChanged<bool> onChanged;
//
//   const SettingToggle({
//     Key? key,
//     required this.title,
//     required this.value,
//     required this.onChanged,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey[800],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Switch(
//             value: value,
//             onChanged: onChanged,
//             activeColor: Colors.white,
//             activeTrackColor: AppColors.primaryBlue,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Add a number input widgets for question count
// class NumberInputField extends StatefulWidget {
//   final int value;
//   final int maxValue;
//   final ValueChanged<int> onChanged;
//
//   const NumberInputField({
//     Key? key,
//     required this.value,
//     required this.maxValue,
//     required this.onChanged,
//   }) : super(key: key);
//
//   @override
//   State<NumberInputField> createState() => _NumberInputFieldState();
// }
//
// class _NumberInputFieldState extends State<NumberInputField> {
//   late TextEditingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: widgets.value.toString());
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: _controller,
//       keyboardType: TextInputType.number,
//       decoration: const InputDecoration(
//         border: OutlineInputBorder(),
//         contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//       ),
//       onChanged: (value) {
//         int? newValue = int.tryParse(value);
//         if (newValue != null) {
//           if (newValue > widgets.maxValue) {
//             newValue = widgets.maxValue;
//             _controller.text = widgets.maxValue.toString();
//           }
//           widgets.onChanged(newValue);
//         }
//       },
//     );
//   }
// }
