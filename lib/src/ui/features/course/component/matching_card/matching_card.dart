import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lingo_master/core/design_systems/theme/app_colors.dart';

import '../../../../../../core/navigation/routers.dart';

class MatchingCardScreen extends StatefulWidget {
  const MatchingCardScreen({super.key});

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
  // Danh sách các cặp từ vựng
  final List<WordPair> _pairs = [
    WordPair(word: 'perishable', translation: 'dễ hư hỏng'),
    WordPair(word: 'earn', translation: 'kiếm được'),
    WordPair(word: '(v) chuyển về, chuyển môn hoá', translation: 'specialize'),
    WordPair(word: 'automobile', translation: 'xe ô tô'),
    WordPair(word: 'regulation', translation: '(n) quy định, quy tắc, điều lệ (v) điều khiển, điều tiết'),
    WordPair(word: 'design', translation: 'thiết kế'),
  ];

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

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _startTimer();

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

  void _initializeGame() {
    // Tạo danh sách các thẻ (từ và dịch)
    List<String> allItems = [];
    for (var pair in _pairs) {
      allItems.add(pair.word);
      allItems.add(pair.translation);
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
                _initializeGame();
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

    for (var pair in _pairs) {
      if ((pair.word == item1 && pair.translation == item2) ||
          (pair.word == item2 && pair.translation == item1)) {
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
            // Xử lý khi nhấn nút đóng
          },
        ),
        title: Text(
          '${_remainingTime.toStringAsFixed(1)} giây',
          style: const TextStyle(
            color: Color(0xFF465060),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
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
      body: SafeArea(
        child: Column(
          children: [
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
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    if (index < _cards.length) {
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
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
