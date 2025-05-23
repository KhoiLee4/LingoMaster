import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_master/core/data/NativeService/card_service.dart';
import 'package:lingo_master/core/data/NativeService/question_service.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';
import 'package:lingo_master/src/ui/features/course/bloc/question_bloc/question_event.dart';
import 'package:lingo_master/src/ui/features/course/bloc/question_bloc/question_state.dart';

import '../../../../../../core/domain/dtos/question/multiple_choice_question_dto.dart';
import '../../../../../../core/navigation/routers.dart';
import '../../bloc/question_bloc/question_bloc.dart';

class StudyProvider extends StatelessWidget {
  final String? id;
  const StudyProvider({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuestionBloc>(
      create: (context) {
        final bloc = QuestionBloc(QuestionsService(), CardService(), id!);
        // Trigger loading folders immediately after creating the bloc
        bloc.add(LoadQuestion());
        return bloc;
      },
      child: StudyScreen(id: id),
    );
  }
}

class StudyScreen extends StatefulWidget {
  final String? id;

  const StudyScreen({super.key, this.id});

  @override
  State<StudyScreen> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Study(),
    );
  }
}

class Study extends StatefulWidget {
  final String? id;
  const Study({super.key, this.id});



  @override
  State<Study> createState() => _StudyState();
}
class _StudyState extends State<Study> {
  @override
  void initState() {
    super.initState();
    // print("ID nhận được: ${widget.id}");
  }

  int currentQuestionIndex = 0;
  int score = 1;
  String? selectedAnswer;
  bool isAnswerCorrect = false;
  bool showFeedback = false;
  bool canProceed = false;
  bool showCorrectAnswer = false;

  void _handleAnswerSelection(
      String selectedOption, List<MultipleChoiceQuestion> questionList) {
    if (showFeedback) return;

    final currentQuestion = questionList[currentQuestionIndex];

    setState(() {
      selectedAnswer = selectedOption;
      isAnswerCorrect = selectedOption == currentQuestion.answer;
      showFeedback = true;

      if (isAnswerCorrect) {
        score++;
      } else {
        showCorrectAnswer = true;
      }

      canProceed = true;

      if (isAnswerCorrect && currentQuestionIndex < questionList.length - 1) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) _proceedToNextQuestion(questionList);
        });
      }
    });
  }

  void _proceedToNextQuestion(List<MultipleChoiceQuestion> questionList) {
    if (!canProceed) return;

    setState(() {
      currentQuestionIndex++;
      selectedAnswer = null;
      showFeedback = false;
      canProceed = false;
      showCorrectAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      builder: (context, state) {
        if (state is QuestionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuestionLoaded) {
          final questionList = state.questions ?? [];

          if (questionList.isEmpty) {
            return const Center(
              child: Text(
                'Chưa có câu hỏi nào',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final currentQuestion = questionList[currentQuestionIndex];
          final progressValue = (currentQuestionIndex + 1) / questionList.length;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close, size: 32, color: Colors.grey[600]),
                          onPressed: () {
                            AppRouter.router.navigateTo(context, "/studySetting", replace: true);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.settings, size: 32, color: Colors.grey[600]),
                          onPressed: () {
                            AppRouter.router.navigateTo(context, "/studySetting", replace: true);
                          },
                        ),
                      ],
                    ),
                  ),

                  // Progress
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Row(
                      children: [
                        // Current Score
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

                        // Progress Bar
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: LinearProgressIndicator(
                              value: progressValue,
                              backgroundColor: Colors.grey[200],
                              color: Colors.green[300],
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),

                        // Total Questions
                        Container(
                          width: 50,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              questionList.length.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Question
                  Text(
                    currentQuestion.question,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Answer Prompt
                  Text(
                    'Chọn câu trả lời',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),

                  // Feedback
                  if (showFeedback)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        isAnswerCorrect ? 'Tuyệt vời!' : 'Chưa đúng, hãy cố gắng nhé!',
                        style: TextStyle(
                          fontSize: 16,
                          color: isAnswerCorrect ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Answer Options
                  ...currentQuestion.choices.map((option) {
                    // Kiểm tra nếu đã ghép hết tất cả các cặp
                    if (currentQuestionIndex >= questionList.length) {
                      _showCompletionDialog();
                    }

                    final isCorrect = option == currentQuestion.answer;
                    final isSelected = selectedAnswer == option;

                    Color borderColor = Colors.grey[300]!;
                    Color textColor = Colors.black;
                    bool showIcon = false;
                    IconData? icon;
                    Color? iconColor;

                    if (showFeedback) {
                      if (isSelected) {
                        borderColor = isCorrect ? Colors.green : Colors.red;
                        textColor = isCorrect ? Colors.green : Colors.red;
                        showIcon = true;
                        icon = isCorrect ? Icons.check : Icons.close;
                        iconColor = isCorrect ? Colors.green : Colors.red;
                      } else if (isCorrect && showCorrectAnswer) {
                        borderColor = Colors.green;
                        textColor = Colors.green;
                        showIcon = true;
                        icon = Icons.check;
                        iconColor = Colors.green;
                      }
                    }



                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: GestureDetector(
                        onTap: () => _handleAnswerSelection(option, questionList),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: showFeedback && (isSelected || isCorrect)
                                ? (isCorrect
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1))
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              if (showIcon)
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Icon(icon, color: iconColor, size: 24),
                                ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: textColor,
                                      fontWeight: isCorrect && showFeedback
                                          ? FontWeight.bold
                                          : FontWeight.normal,
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

                  // Continue Button (for wrong answers)
                  if (showFeedback && !isAnswerCorrect)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => _proceedToNextQuestion(questionList),
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
          );
        } else if (state is QuestionError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lỗi: ${state.message}"),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<QuestionBloc>().add(LoadQuestion());
                  },
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.read<QuestionBloc>().add(LoadQuestion());
            }
          });
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Chúc mừng!'),
        content: const Text('Bạn đã hoàn thành.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Ở đây có thể thêm logic chuyển sang màn hình tiếp theo
              AppRouter.router.navigateTo(context, "/coursePage/${widget.id}", replace: true);
            },
            child: const Text('Tiếp tục'),
          ),
        ],
      ),
    );
  }
}