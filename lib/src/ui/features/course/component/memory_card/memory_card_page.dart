import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_master/core/data/IncludeService/GoogleService/text_to_speech.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../../../../core/data/NativeService/card_service.dart';
import '../../../../../../core/navigation/routers.dart';
import '../../bloc/course_bloc/course_bloc.dart';
import '../../bloc/course_bloc/course_event.dart';
import '../../bloc/course_bloc/course_state.dart';

class MemoryCardProvider extends StatelessWidget {
  final String? id;
  const MemoryCardProvider({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourseBloc>(
      create: (context) {
        final bloc = CourseBloc(CardService(), id!);
        // Trigger loading folders immediately after creating the bloc
        bloc.add(LoadCard());
        return bloc;
      },
      child: MemoryCardScreen(id: id,),
    );
  }
}

class MemoryCardScreen extends StatefulWidget {
  final String? id;
  const MemoryCardScreen({super.key, this.id});

  @override
  State<MemoryCardScreen> createState() => _MemoryCardScreenState();
}

class _MemoryCardScreenState extends State<MemoryCardScreen>
    with SingleTickerProviderStateMixin {
  // Offset _dragOffset = Offset.zero;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDefault,
      body: FlashCard(),
    );
  }
}

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard>  with TickerProviderStateMixin  {
  int currentIndex = 2; // Starting at 39/95 (0-indexed)
  int numCardMemory = 0;
  int numCardForgot = 0;

  bool showSettings = false;
  Offset _dragOffset = Offset.zero;

  // For draggable card
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  BorderSide _cardBorder = BorderSide.none;

  late AnimationController _flipController;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.addListener(() {
      setState(() {});
    });

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _flipController.dispose();
    super.dispose();
  }


  //------ Update 

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dragPercentage = _dragOffset.dx / (screenWidth / 2);
    final rotationAngle = dragPercentage * 0.2; // Adjust rotation based on drag
    // final totalCards = 95;

    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        if (state is CourseLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CourseLoaded) {
          if (state.cards == null) {
            return const Center(
              child: Text(
                'Chưa có thẻ nào',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          int totalCards = state.cards?.length ?? 0;
          return Stack(
            children: [
              // Main content
              SafeArea(
                child: Column(
                  children: [
                    // Top navigation bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close,
                                color: AppColors.neutralGray600, size: 30),
                            onPressed: () {
                              // Handle close button press
                              AppRouter.router.navigateTo(context, "/home");
                            },
                          ),
                          Text(
                            "${currentIndex + 1} / $totalCards",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.neutralGray600,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.settings,
                                color: AppColors.neutralGray600),
                            onPressed: () {
                              setState(() {
                                showSettings = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Progress bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.neutralGray300,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: (currentIndex + 1) / totalCards,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.neutralGray800,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Score indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF4E8),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: const Color(0xFFFF9F40), width: 1),
                          ),
                          child: Text(
                            numCardForgot.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD95E00),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8FFF4),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: const Color(0xFF40FFB0), width: 1),
                          ),
                          child: Text(
                            numCardMemory.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00D968),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Flashcard
                    // Flashcard
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle card flip
                            if (_flipController.isCompleted) {
                              _flipController.reverse();
                            } else {
                              _flipController.forward();
                            }
                          },
                          onPanStart: (details) {
                            _animationController.stop();
                          },
                          onPanUpdate: (details) {
                            setState(() {
                              _dragOffset += details.delta;

                              // Change border color based on drag direction
                              if (_dragOffset.dx < 0) {
                                // Orange border for left swipe
                                _cardBorder = const BorderSide(
                                    color: Color(0xFFFF9F40), width: 2);
                              } else if (_dragOffset.dx > 0) {
                                // Green border for right swipe
                                _cardBorder = const BorderSide(
                                    color: Color(0xFF40FFB0), width: 2);
                              } else {
                                _cardBorder = BorderSide.none;
                              }
                            });
                          },
                          onPanEnd: (details) {
                            final velocity = details.velocity.pixelsPerSecond.dx;
                            final screenWidth = MediaQuery.of(context).size.width;

                            // If dragged far enough or with enough velocity, move to next card
                            if (_dragOffset.dx.abs() > screenWidth / 4 ||
                                velocity.abs() > 500) {
                              final direction = _dragOffset.dx > 0 ? 1.0 : -1.0;
                              // Tăng số dựa trên hướng vuốt
                              setState(() {
                                if (direction > 0) {
                                  // Right swipe - Remember/Memory
                                  numCardMemory++;
                                } else {
                                  // Left swipe - Forgot
                                  numCardForgot++;
                                }
                              });

                              // Kiểm tra xem đây có phải card cuối cùng không
                              if (currentIndex >= totalCards - 1) {
                                // Đây là card cuối cùng, chuyển trang
                                AppRouter.router.navigateTo(context, "/memoryCardSuccess/${state.cards!.length ?? 0}/${numCardMemory}/${numCardForgot}", replace: true);
                              }

                              _animation = Tween<Offset>(
                                begin: _dragOffset,
                                end: Offset(direction * screenWidth, 0),
                              ).animate(CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.easeOutCubic,
                              ));

                              _animationController.forward(from: 0).then((_) {
                                setState(() {
                                  // Move to next card
                                  if (currentIndex < totalCards - 1) {
                                    currentIndex++;
                                  } else {
                                    currentIndex = 0;
                                  }

                                  // Reset position and flip state
                                  _dragOffset = Offset.zero;
                                  _cardBorder = BorderSide.none;
                                  _animationController.reset();
                                  _flipController.reset(); // Reset flip animation for new card
                                });
                              });
                            } else {
                              // Snap back if not dragged far enough
                              _animation = Tween<Offset>(
                                begin: _dragOffset,
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.easeOutCubic,
                              ));

                              _animationController.forward(from: 0).then((_) {
                                setState(() {
                                  _dragOffset = Offset.zero;
                                  _cardBorder = BorderSide.none;
                                });
                              });
                            }
                          },
                          child: Transform.translate(
                            offset: _animationController.isAnimating
                                ? _animation.value
                                : _dragOffset,
                            child: Transform.rotate(
                              angle: rotationAngle,
                              child: AnimatedBuilder(
                                animation: _flipController,
                                builder: (context, child) {
                                  // Determine which side of the card to show
                                  final isShowingFront = _flipController.value < 0.5;
                                  return Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.001)
                                      ..rotateY(_flipController.value * 3.14),
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: _cardBorder,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryWhite,
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 8),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(Icons.volume_up,
                                                        color: AppColors.neutralGray300),
                                                    onPressed: () {
                                                      if(isShowingFront)
                                                      {
                                                        var  tts =  FlutterTts();
                                                          tts.setLanguage("en-US");
                                                          tts.setPitch(1.0);
                                                          tts.setSpeechRate(0.5);
                                                          tts.setVolume(1.0);
                                                          tts.speak(state.cards![currentIndex % state.cards!.length].key.toString());

                                                      }
                                                      else
                                                      {
                                                         var  tts =  FlutterTts();
                                                          tts.setLanguage("vi-VI");
                                                          tts.setPitch(1.0);
                                                          tts.setSpeechRate(0.5);
                                                          tts.setVolume(1.0);
                                                          tts.speak(state.cards![currentIndex % state.cards!.length].value.toString());

                                                      }
                                                     
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(Icons.star_border,
                                                        color: AppColors.neutralGray300),
                                                    onPressed: () {
                                                      // Handle favorite action
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Center(
                                              child: Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.identity()
                                                  ..rotateY(isShowingFront ? 0 : 3.14),
                                                child: Text(
                                                  isShowingFront
                                                      ? state.cards![currentIndex % state.cards!.length].key.toString()
                                                      : state.cards![currentIndex % state.cards!.length].value.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.neutralGray600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            // Add flip indicator
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 16.0),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 12, vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: AppColors.neutralGray200,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  isShowingFront ? "Ấn để xem nghĩa" : "Ấn để xem từ",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.neutralGray500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Bottom navigation
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.grey),
                            onPressed: () {
                              // Handle refresh action
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.play_arrow, color: Colors.grey),
                            onPressed: () {
                              // Handle play action
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Settings overlay
              if (showSettings)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showSettings = false;
                    });
                  },
                  child: Container(
                    color: const Color(0x99333344),
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {}, // Prevent tap through

                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryWhite,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 16),
                                  Container(
                                    width: 40,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: AppColors.neutralGray300,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    "Tùy chọn",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.neutralGray800,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              border:
                                              Border.all(color: AppColors.neutralGray500, width: 3,),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.shuffle,
                                                color: AppColors.neutralGray500),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text("Trộn thẻ",
                                              style: TextStyle(color: AppColors.neutralGray500)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              border:
                                              Border.all(color: AppColors.neutralGray500, width: 3,),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.volume_up,
                                                color: AppColors.neutralGray500),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text("Phát bản thu",
                                              style: TextStyle(color: AppColors.neutralGray500)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Sắp xếp",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.neutralGray800
                                          ),
                                        ),
                                        Switch(
                                          value: true,
                                          onChanged: (value) {},
                                          activeColor: Colors.white,
                                          activeTrackColor: AppColors.primaryBlue,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      "Sắp xếp thẻ của bạn để tập trung vào những thuật ngữ cần chú tâm học. Tắt tính năng sắp xếp nếu bạn muốn nhanh chóng ôn lại các thẻ ghi nhớ.",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.neutralGray600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Thiết lập thẻ ghi nhớ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Mặt trước",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.neutralGray500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryBlue,
                                              border: Border.all(
                                                  color: AppColors.primaryBlue, width: 2),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomLeft: Radius.circular(8),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "Tiếng Anh",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: AppColors.primaryBlue, width: 2),
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                bottomRight: Radius.circular(8),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "Tiếng Việt",
                                              style: TextStyle(
                                                color: AppColors.primaryBlue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Đặt lại Thẻ ghi nhớ",
                                      style: TextStyle(
                                          color: AppColors.primaryBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),

                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          );
        } else if (state is CourseError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lỗi: ${state.message}"),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<CourseBloc>().add(LoadCard());
                  },
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          );
        } else {
          // Initial state - trigger loading if not already loaded
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.read<CourseBloc>().add(LoadCard());
            }
          });

          return const Center(child: CircularProgressIndicator());
        }
      },
    );


  }
  void _showNextCard({bool isLeftSwipe = true}) {
    setState(() {
      if (currentIndex < 39 - 1) {
        currentIndex++;
      } else {
        currentIndex = 0; // Loop back to the beginning
      }
    });
  }
}

