import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

import '../../../../../../core/navigation/routers.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyScreen> {
  // List of questions and their options
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'đồ uống',
      'options': ['drink/beverage', 'dinner', 'dining room', 'refreshment'],
      'correctAnswer': 'drink/beverage',
    },
    {
      'question': 'đồ ăn vặt',
      'options': ['snack', 'fruit', 'lunch', 'entree'],
      'correctAnswer': 'snack',
    },
    {
      'question': '(n) nhân viên',
      'options': ['generate', 'employee', 'colleague', 'practice'],
      'correctAnswer': 'employee',
    },
  ];

  int currentQuestionIndex = 0;
  int score = 1; // Starting with 1 as shown in the images
  String? selectedAnswer;
  bool isAnswerCorrect = false;
  bool showFeedback = false;
  bool canProceed = false;
  bool showCorrectAnswer = false;

  void _handleAnswerSelection(String selectedOption) {
    if (showFeedback) return; // Prevent selecting another answer during feedback

    final currentQuestion = questions[currentQuestionIndex];

    setState(() {
      selectedAnswer = selectedOption;
      isAnswerCorrect = selectedOption == currentQuestion['correctAnswer'];
      showFeedback = true;

      // Only increment score for correct answers
      if (isAnswerCorrect) {
        score++;
      } else {
        // Show the correct answer when the user selects the wrong answer
        showCorrectAnswer = true;
      }

      canProceed = true;

      // Auto proceed to next question after a delay
      if (currentQuestionIndex < questions.length - 1) {
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            _proceedToNextQuestion();
          }
        });
      }
    });
  }

  void _proceedToNextQuestion() {
    if (!canProceed) return;

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        showFeedback = false;
        canProceed = false;
        showCorrectAnswer = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar with back button and settings
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle back button press
                      },
                      child: Icon(Icons.close, size: 32, color: Colors.grey[600]),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppRouter.router.navigateTo(context, "/studySetting", replace: true);
                      },
                      child: Icon(Icons.settings, size: 32, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              // Progress bar with scores
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Row(
                  children: [
                    // Score on the left
                    Container(
                      width: 50,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          score.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Progress bar in the middle
                    Expanded(
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

                    // Score on the right (target/total)
                    Container(
                      width: 50,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          '46',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Feedback for the current answer


              // Question text
              Text(
                questions[currentQuestionIndex]['question'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),


              // Answer selection text
              Text(
                'Chọn câu trả lời',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              if (showFeedback)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    isAnswerCorrect
                        ? 'Tuyệt vời!'
                        : 'Chưa đúng, hãy cố gắng nhé!',
                    style: TextStyle(
                      fontSize: 16,
                      color: isAnswerCorrect ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Answer options
              ...(questions[currentQuestionIndex]['options'] as List<String>).map((option) {
                final isCorrectOption = option == questions[currentQuestionIndex]['correctAnswer'];
                final bool isSelected = selectedAnswer == option;
                final bool showCorrectIcon = isSelected && isCorrectOption;
                final bool showIncorrectIcon = isSelected && !isCorrectOption;
                final bool highlightCorrectAnswer = showCorrectAnswer && isCorrectOption;

                Color borderColor = Colors.grey[300]!;
                if (showCorrectIcon || highlightCorrectAnswer) {
                  borderColor = Colors.green;
                } else if (showIncorrectIcon) {
                  borderColor = Colors.red;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: GestureDetector(
                    onTap: () => _handleAnswerSelection(option),
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                          width: (showFeedback && isSelected) || highlightCorrectAnswer ? 2.0 : 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: showCorrectIcon || highlightCorrectAnswer
                            ? Colors.green.withOpacity(0.1)
                            : showIncorrectIcon
                            ? Colors.red.withOpacity(0.1)
                            : Colors.white,
                      ),
                      child: Row(
                        children: [
                          // Checkmark or X icon
                          if (showCorrectIcon || showIncorrectIcon || highlightCorrectAnswer)
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Icon(
                                showIncorrectIcon ? Icons.close : Icons.check,
                                color: showIncorrectIcon ? Colors.red : Colors.green,
                                size: 24,
                              ),
                            ),

                          Expanded(
                            child: Center(
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: showIncorrectIcon ? Colors.red :
                                  highlightCorrectAnswer ? Colors.green :
                                  Colors.black,
                                  fontWeight: highlightCorrectAnswer ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              // Continue button (shows up when feedback is displayed)
              if (showFeedback && !isAnswerCorrect)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _proceedToNextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Tiếp tục',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
