import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

import '../../../../../../core/data/NativeService/card_service.dart';
import '../../../../../../core/data/NativeService/question_service.dart';
import '../../../../../../core/domain/dtos/question/multiple_choice_question_dto.dart';
import '../../../../../../core/navigation/routers.dart';
import '../../bloc/question_bloc/question_bloc.dart';
import '../../bloc/question_bloc/question_event.dart';
import '../../bloc/question_bloc/question_state.dart';

class TestProvider extends StatelessWidget {
  final String? id;
  const TestProvider({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuestionBloc>(
      create: (context) {
        final bloc = QuestionBloc(QuestionsService(), CardService(), id!);
        bloc.add(LoadQuestion());
        return bloc;
      },
      child: TestScreen(id: id),
    );
  }
}

class TestScreen extends StatefulWidget {
  final String? id;
  const TestScreen({super.key, this.id});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black54),
          onPressed: () {
            // Handle closing the quiz
            AppRouter.router.navigateTo(context, "/home", replace: true);
          },
        ),
        centerTitle: true,
      ),
      body: Test(id: widget.id),
    );
  }
}

class Test extends StatefulWidget {
  final String? id;
  const Test({super.key, this.id});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int correctAnswersCount = 0;
  bool isTransitioning = false;
  
  late List<MultipleChoiceQuestion> questions = [];
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _selectAnswer(int index, List<MultipleChoiceQuestion> questionList) {
    if (isTransitioning) return;
    
    setState(() {
      selectedAnswerIndex = index;
      isTransitioning = true;
    });

    // Check answer silently
    final currentQuestion = questionList[currentQuestionIndex];
    final selectedOption = currentQuestion.choices[index];
    final isCorrect = selectedOption == currentQuestion.answer;
    
    if (isCorrect) {
      correctAnswersCount++;
    }

    // Add selection animation
    _fadeController.reverse().then((_) {
      // Delay before next question for smooth transition
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          _nextQuestion();
        }
      });
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex >= questions.length - 1) {
      // Quiz completed - navigate to success screen
      AppRouter.router.navigateTo(
        context, 
        "/testSuccess/${widget.id}/$correctAnswersCount/${questions.length - correctAnswersCount}", 
        replace: true
      );
      return;
    }

    // Move to next question with smooth transition
    setState(() {
      currentQuestionIndex++;
      selectedAnswerIndex = null;
      isTransitioning = false;
    });
    
    // Restart animations for new question
    _fadeController.forward();
    _slideController.reset();
    _slideController.forward();
  }

  Color _getOptionColor(int index) {
    if (selectedAnswerIndex == index) {
      return const Color(0xFF4F46E5);
    }
    return const Color(0xFFE2E8F0);
  }

  Color _getOptionTextColor(int index) {
    if (selectedAnswerIndex == index) {
      return const Color(0xFF4F46E5);
    }
    return const Color(0xFF4A5568);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      builder: (context, state) {
        if (state is QuestionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuestionLoaded) {
          if (state.questions == null || state.questions!.isEmpty) {
            return const Center(
              child: Text(
                'Chưa có câu hỏi nào',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          
          questions = state.questions!;
          
          // Safety check
          if (currentQuestionIndex >= questions.length) {
            currentQuestionIndex = questions.length - 1;
          }

          final currentQuestion = questions[currentQuestionIndex];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Column(
                  children: [
                    // Question counter
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${currentQuestionIndex + 1}/${questions.length}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4F46E5).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Câu ${currentQuestionIndex + 1}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4F46E5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Progress bar with animation
                    Stack(
                      children: [
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          width: MediaQuery.of(context).size.width * 0.9 * 
                                 ((currentQuestionIndex + 1) / questions.length),
                          height: 6,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Question with animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        currentQuestion.question,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3748),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Instruction
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Chọn câu trả lời đúng nhất",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Answer options with staggered animation
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: currentQuestion.choices.length,
                    itemBuilder: (context, index) {
                      final option = currentQuestion.choices[index];
                      
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 200 + (index * 100)),
                        curve: Curves.easeOutBack,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: _buildOptionCard(option, index, questions),
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
            ],
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
            if (context.mounted) {
              context.read<QuestionBloc>().add(LoadQuestion());
            }
          });
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildOptionCard(String option, int index, List<MultipleChoiceQuestion> questionList) {
    final bool isSelected = selectedAnswerIndex == index;
    
    return GestureDetector(
      onTap: isTransitioning ? null : () => _selectAnswer(index, questionList),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected 
            ? const Color(0xFF4F46E5).withOpacity(0.1) 
            : Colors.white,
          border: Border.all(
            color: _getOptionColor(index),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF4F46E5).withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Radio button indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF4F46E5) : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected ? const Color(0xFF4F46E5) : Colors.transparent,
              ),
              child: isSelected
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 16,
                  color: _getOptionTextColor(index),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              AnimatedScale(
                scale: isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Đã chọn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}