import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

import '../../../../../../core/navigation/routers.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class QuizQuestion {
  final String term;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.term,
    required this.options,
    required this.correctAnswerIndex,
  });
}


class _TestScreenState extends State<TestScreen> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool hasAnswered = false;

  // Initialize questions list at declaration
  late final List<QuizQuestion> questions;

  @override
  void initState() {
    super.initState();
    // Initialize questions in initState
    questions = [
      QuizQuestion(
        term: "báo chí",
        options: ["rely on", "press", "respect", "extra"],
        correctAnswerIndex: 1, // "press" is the correct answer
      ),
      QuizQuestion(
        term: "tin tức",
        options: ["news", "respect", "depend", "question"],
        correctAnswerIndex: 0,
      ),
      // Add more questions as needed
      QuizQuestion(
        term: "kính trọng",
        options: ["extra", "press", "respect", "rely on"],
        correctAnswerIndex: 2,
      ),
    ];
  }

  void _selectAnswer(int index) {
    setState(() {
      selectedAnswerIndex = index;
      hasAnswered = true;
    });

    // Move to the next question after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        hasAnswered = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure we have valid questions and index
    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No questions available")),
      );
    }

    // Safety check to prevent index out of range errors
    if (currentQuestionIndex >= questions.length) {
      currentQuestionIndex = questions.length - 1;
    }

    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black54),
          onPressed: () {
            // Handle closing the quiz
            AppRouter.router.navigateTo(context, "/coursepage", replace: true);
          },
        ),
        title: Text(
          "${currentQuestionIndex + 1}/${questions.length}",
          style: const TextStyle(color: Colors.black54),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Divider(height: 1, color: Colors.grey),
          // Progress bar with scores
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
                // Progress bar in the middle
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: (currentQuestionIndex + 1) / questions.length,
                          child: Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.green[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              currentQuestion.term,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Chọn câu trả lời",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: currentQuestion.options.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildOptionCard(currentQuestion.options[index], index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String option, int index) {
    final bool isSelected = selectedAnswerIndex == index;

    return GestureDetector(
      onTap: hasAnswered ? null : () => _selectAnswer(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          option,
          style: TextStyle(
            fontSize: 18,
            color: isSelected ? Colors.blue : Colors.black87,
          ),
        ),
      ),
    );
  }
}
