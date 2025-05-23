import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';
import 'package:lingo_master/src/ui/features/course/bloc/course_bloc/course_event.dart';

import '../../../../../../core/data/NativeService/card_service.dart';
import '../../../../../../core/navigation/routers.dart';
import '../../bloc/course_bloc/course_bloc.dart';
import '../../bloc/course_bloc/course_state.dart';

class MatchingCardProvider extends StatelessWidget {
  final String? id;
  const MatchingCardProvider({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourseBloc>(
      create: (context) {
        final bloc = CourseBloc(CardService(), id!);
        // Trigger loading folders immediately after creating the bloc
        bloc.add(LoadCard());
        return bloc;
      },
      child: MatchingCardScreen(id: id,),
    );
  }
}

class MatchingCardScreen extends StatefulWidget {
  final String? id;
  const MatchingCardScreen({super.key, this.id});

  @override
  State<MatchingCardScreen> createState() => _MatchingCardState();
}
class WordPair {
  final String word;
  final String translation;
  bool isMatched;

  WordPair({required this.word, required this.translation, this.isMatched = false});
}

class _MatchingCardState extends State<MatchingCardScreen> with TickerProviderStateMixin  {
  // Thời gian còn lại (đổi thành 120 giây = 2 phút)
  double _remainingTime = 120.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Color(0xFF465060),
            size: 30,
          ),
          onPressed: () {
            AppRouter.router.navigateTo(context, "/home");
          },
        ),
        // title: Text(
        //   '${_remainingTime.toStringAsFixed(1)} giây',
        //   style: const TextStyle(
        //     color: Color(0xFF465060),
        //     fontSize: 24,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.volume_up,
              color: Color(0xFF465060),
            ),
            onPressed: () {
              // Xử lý khi nhấn nút âm thanh
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Color(0xFF465060),
            ),
            onPressed: () {
              // Xử lý khi nhấn nút cài đặt
            },
          ),
        ],
      ),
      body: Maching(),
    );
  }
}
class Maching extends StatefulWidget {
  const Maching({super.key});

  @override
  State<Maching> createState() => _MachingState();
}

class _MachingState extends State<Maching> with TickerProviderStateMixin {
  // Danh sách các thẻ được hiển thị
  List<String> _cards = [];
  // Thẻ đang được chọn
  int? _selectedIndex;
  // Thẻ chọn trước đó
  int? _previousIndex;
  // Trạng thái thẻ (màu)
  Map<int, Color> _cardColors = {};
  // Trạng thái hiển thị của thẻ
  Map<int, bool> _cardVisibility = {};
  // Thời gian còn lại (đổi thành 120 giây = 2 phút)
  double _remainingTime = 120.0;
  // Timer đếm giờ
  Timer? _timer;
  // Timer để delay trước khi ẩn/đổi màu thẻ
  Timer? _pairCheckTimer;
  // Đếm số cặp đã ghép thành công
  int _matchedPairs = 0;
  // Controller cho animation lắc
  late final List<AnimationController> _shakeControllers = [];
  // Lưu trữ danh sách cặp từ từ bloc
  List<dynamic> _pairs = [];

  @override
  void initState() {
    super.initState();
    // Khởi tạo animation controllers cho mỗi thẻ
    for (int i = 0; i < 12; i++) {
      _shakeControllers.add(AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pairCheckTimer?.cancel();
    for (var controller in _shakeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeGame(List<dynamic> cards) {
    final random = Random();

    // Chọn ngẫu nhiên 6 cặp từ danh sách ban đầu
    cards.shuffle(random); // Xáo trộn toàn bộ danh sách ban đầu
    _pairs = cards.take(6).toList(); // Lấy 6 cặp đầu tiên

    // Tạo danh sách các thẻ (từ và dịch)
    List<String> allItems = [];
    for (var card in _pairs) {
      allItems.add(card.key); // word
      allItems.add(card.value); // translation
    }

    // Xáo trộn danh sách
    allItems.shuffle(Random());

    // Gán danh sách đã xáo trộn
    _cards = allItems;

    // Khởi tạo màu cho các thẻ (trắng)
    for (int i = 0; i < _cards.length; i++) {
      _cardColors[i] = Colors.white;
      _cardVisibility[i] = true; // Tất cả thẻ đều hiển thị ban đầu
    }
  }

  void _startTimer() {
    _timer?.cancel(); // Hủy timer cũ nếu có
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime -= 0.1;
        } else {
          _timer?.cancel();
          // Xử lý khi hết thời gian
          _showTimeUpDialog();
        }
      });
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Hết giờ!'),
        content: const Text('Thời gian đã hết. Bạn có muốn chơi lại không?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Reset game
              setState(() {
                _remainingTime = 120.0;
                _matchedPairs = 0;
                _selectedIndex = null;
                _previousIndex = null;
                _initializeGame(_pairs);
                _startTimer();
              });
            },
            child: const Text('Chơi lại'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Xử lý khi người dùng không muốn chơi lại
              // Có thể trở về màn hình trước đó
            },
            child: const Text('Thoát'),
          ),
        ],
      ),
    );
  }

  // Tìm cặp từ tương ứng
  bool _isMatching(int index1, int index2) {
    String item1 = _cards[index1];
    String item2 = _cards[index2];

    for (var card in _pairs) {
      String word = card.key;
      String translation = card.value;

      if ((word == item1 && translation == item2) ||
          (word == item2 && translation == item1)) {
        return true;
      }
    }
    return false;
  }

  // Xử lý khi chọn thẻ
  void _selectCard(int index) {
    // Không cho phép chọn thẻ đã ghép đúng, đang đợi kiểm tra hoặc đã ẩn
    if (_pairCheckTimer != null || _cardVisibility[index] == false) {
      return;
    }

    setState(() {
      if (_selectedIndex == null) {
        // Chọn thẻ đầu tiên
        _selectedIndex = index;
        _cardColors[index] = const Color(0xFF9C27B0); // Màu tím
      } else if (_selectedIndex != index) {
        // Chọn thẻ thứ hai
        _previousIndex = _selectedIndex;
        _cardColors[index] = const Color(0xFF9C27B0); // Màu tím

        // Kiểm tra cặp thẻ có khớp không
        _pairCheckTimer = Timer(const Duration(milliseconds: 500), () {
          setState(() {
            if (_isMatching(_previousIndex!, index)) {
              // Ghép đúng
              _cardColors[_previousIndex!] = Colors.green;
              _cardColors[index] = Colors.green;
              _matchedPairs++;

              // Kiểm tra nếu đã ghép hết tất cả các cặp
              if (_matchedPairs == _pairs.length) {
                _timer?.cancel();
                _showCompletionDialog();
              }

              // Đợi một chút trước khi ẩn cặp thẻ đúng
              int i1 = _previousIndex!;
              int i2 = index;

              Timer(const Duration(milliseconds: 1000), () {
                setState(() {
                  _cardVisibility[i1] = false;
                  _cardVisibility[i2] = false;
                });
              });

            } else {
              // Ghép sai
              _cardColors[_previousIndex!] = Colors.red;
              _cardColors[index] = Colors.red;

              // Kích hoạt hiệu ứng lắc
              _shakeControllers[_previousIndex!].forward(from: 0.0);
              _shakeControllers[index].forward(from: 0.0);

              // Đợi lâu hơn (1.5 giây) trước khi đổi lại màu trắng
              int i1 = _previousIndex!;
              int i2 = index;

              Timer(const Duration(milliseconds: 1500), () {
                setState(() {
                  _cardColors[i1] = Colors.white;
                  _cardColors[i2] = Colors.white;
                });
              });
            }
            _selectedIndex = null;
            _previousIndex = null;
            _pairCheckTimer = null;
          });
        });
      }
    });
  }


  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Chúc mừng!'),
        content: const Text('Bạn đã hoàn thành trò chơi.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Ở đây có thể thêm logic chuyển sang màn hình tiếp theo
              AppRouter.router.navigateTo(context, "/matchingCardResult", replace: true);
            },
            child: const Text('Tiếp tục'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        if (state is CourseLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CourseLoaded) {
          if (state.cards == null || state.cards!.isEmpty) {
            return const Center(
              child: Text(
                'Chưa có thẻ nào',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          // Khởi tạo game khi có dữ liệu từ bloc
          if (_cards.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _initializeGame(state.cards!);
              _startTimer();
            });
          }

          return SafeArea(
            child: Column(
              children: [
                // Hiển thị thời gian còn lại
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thời gian: ${_remainingTime.toStringAsFixed(1)}s',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Cặp đã ghép: $_matchedPairs/${_pairs.length}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _cards.length,
                      itemBuilder: (context, index) {
                        // Kiểm tra xem thẻ có nên hiển thị không
                        if (_cardVisibility[index] == false) {
                          // Thẻ đã bị ẩn (ghép đúng)
                          return const SizedBox.shrink(); // Không chiếm chỗ
                        }

                        return AnimatedBuilder(
                          animation: _shakeControllers[index],
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                sin(_shakeControllers[index].value * 4 * pi) * 10,
                                0,
                              ),
                              child: child,
                            );
                          },
                          child: GestureDetector(
                            onTap: () => _selectCard(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: _cardColors[index],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _cards[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: _cardColors[index] == Colors.white ?
                                      Colors.black : Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
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
}