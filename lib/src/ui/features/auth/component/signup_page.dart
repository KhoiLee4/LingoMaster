import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lingo_master/src/ui/features/auth/bloc/signup/signup_bloc.dart';
import 'package:lingo_master/src/ui/features/auth/bloc/signup/sigup_state.dart';
import '../../../../../core/navigation/routers.dart';
import '../bloc/signup/signup_event.dart';

class SignupProvider extends StatelessWidget {
  const SignupProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(),
      child: SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _birthday = TextEditingController();
  DateTime? _selectedBirthday;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedBirthday = picked;
        _birthday.text = DateFormat('dd/MM/yyyy').format(picked);
        // _birthday.text = Format;
      });
    }
  }

  void _onRegisterPressed() {
    final birthday = _selectedBirthday;
    final email = _email.text.trim();
    final password = _password.text.trim();

    context.read<SignupBloc>().add(
          SignupSubmitted(birthday: birthday, email: email, password: password),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () {
            AppRouter.router.navigateTo(context, "/wellcome", replace: true);
          },
        ),
      ),
      body: SafeArea(
        child:
            BlocConsumer<SignupBloc, SignupState>(listener: (context, state) {
          if (state is SignupSuccess) {
            AppRouter.router.navigateTo(context, "/signin", replace: true);
          } else if (state is SignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Tạo tài khoản',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF252A31),
                  ),
                ),
                const SizedBox(height: 40),

                // Date of birth field
                TextField(
                  controller: _birthday,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    hintText: 'Ngày sinh',
                    hintStyle: const TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: const Color(0xFFF6F7FB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.info_outline,
                        color: Colors.black45,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Email field
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: const Color(0xFFF6F7FB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field
                TextField(
                  controller: _password,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: 'Mật khẩu',
                    hintStyle: const TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: const Color(0xFFF6F7FB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Terms and Conditions text
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Bằng việc đăng ký, bạn chấp nhận ',
                        ),
                        TextSpan(
                          text: 'Điều khoản dịch vụ',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' và ',
                        ),
                        TextSpan(
                          text: 'Chính sách quyền riêng tư',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' của Quizlet',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Create Account button
                state is SignupLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          _onRegisterPressed();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD9DEE8),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Tạo tài khoản',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios_new),
            label: '',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black45,
        unselectedItemColor: Colors.black45,
      ),
    );
  }
}
