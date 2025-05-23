import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingo_master/core/data/NativeService/AccountService.dart';
import 'package:lingo_master/core/domain/models/session.dart';
import '../../../../../core/navigation/routers.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  // Tạo 6 controller cho 6 ô nhập OTP
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  // Danh sách focus node cho từng ô nhập liệu
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  String get _otpCode {
    return _otpControllers.map((controller) => controller.text).join();
  }

  void _verifyOtpCode() async{
    // Kiểm tra xem đã nhập đủ 6 số chưa
    if (_otpCode.length == 6) {
      // Thực hiện logic xác minh OTP ở đây
      print('OTP Code: $_otpCode');
      var req = await new AccountService().verify(_otpCode);
      if(req.Success == true) {
        // Nếu xác minh thành công, điều hướng đến trang chính
        AppRouter.router.navigateTo(context, "/signin", replace: true);
      } else {
        // Nếu xác minh thất bại, hiển thị thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(req.Message.toString())),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đủ mã OTP 6 số')),
      );
    }


  }

  // Di chuyển focus sang ô tiếp theo khi đã nhập
  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Nếu ô hiện tại đã có dữ liệu và không phải ô cuối cùng, di chuyển đến ô tiếp theo
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Nếu là ô cuối cùng, ẩn bàn phím
        FocusManager.instance.primaryFocus?.unfocus();
        // Tự động xác minh khi đã nhập đủ 6 số
        _verifyOtpCode();
      }
    }
  }

  // Di chuyển focus về ô trước đó khi xóa
  void _onBackspacePressed(String value, int index) {
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }



  @override
  void dispose() {
    // Giải phóng tài nguyên
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác minh email'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.email_outlined,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Chúng tôi đã gửi mã xác minh đến',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              Session.email ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Nhập mã xác minh 6 số',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            // 6 ô nhập OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => Container(
                  width: 45,
                  height: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) => _onOtpChanged(value, index),
                    onEditingComplete: () {
                      if (index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      }
                    },
                    onSubmitted: (_) {
                      if (index == 5) {
                        _verifyOtpCode();
                      }
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyOtpCode,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Xác minh', style: TextStyle(fontSize: 16)),
              ),
            ),

            TextButton(
              onPressed: () {
                AppRouter.router.navigateTo(context, "/signin", replace: true);
              },
              child: const Text(
                'Quay lại trang đăng nhập',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}