// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lingo_master/core/data/NativeService/AccountService.dart';
// import 'package:lingo_master/core/domain/dtos/register_user_dto.dart';
// import 'package:lingo_master/core/domain/models/session.dart';
// import 'package:lingo_master/src/ui/features/auth/bloc/signup/signup_bloc.dart';
// import 'package:lingo_master/src/ui/features/auth/bloc/signup/sigup_state.dart';
// import '../../../../../core/navigation/routers.dart';
// import '../bloc/signup/signup_event.dart';
//
// class SignupProvider extends StatelessWidget {
//   const SignupProvider({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<SignupBloc>(
//       create: (context) => SignupBloc(),
//       child: SignupScreen(),
//     );
//   }
// }
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController _firstName = TextEditingController();
//   final TextEditingController _lastName = TextEditingController();
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   bool _obscureText = true;
//
//   void _onRegisterPressed() async{
//     final firstName = _firstName.text.trim();
//     final lastName = _lastName.text.trim();
//     final email = _email.text.trim();
//     final password = _password.text.trim();
//     if(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Vui lòng điền đầy đủ thông tin'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return;
//     }
//
//     // call
//     var req = RegisterUserDto(
//       email: email,
//       userName: email,
//       password: password,
//       firstName: firstName,
//       lastName: lastName,
//     );
//     var rep =await new AccountService().createAccount(req);
//     if (rep.Success == true) {
//       Session.email = email;
//       // Navigate to the next screen
//       AppRouter.router.navigateTo(context, "/verification", replace: true);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(rep.Message!),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black54),
//           onPressed: () {
//             AppRouter.router.navigateTo(context, "/wellcome", replace: true);
//           },
//         ),
//       ),
//       body: SafeArea(
//         child:
//             BlocConsumer<SignupBloc, SignupState>(listener: (context, state) {
//           if (state is SignupSuccess) {
//             AppRouter.router.navigateTo(context, "/signin", replace: true);
//           } else if (state is SignupFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.error)),
//             );
//           }
//         }, builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Tạo tài khoản',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF252A31),
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//
//                   // First Name field
//                   TextField(
//                     controller: _firstName,
//                     decoration: InputDecoration(
//                       hintText: 'Tên',
//                       hintStyle: const TextStyle(color: Colors.black45),
//                       filled: true,
//                       fillColor: const Color(0xFFF6F7FB),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 16),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Last Name field
//                   TextField(
//                     controller: _lastName,
//                     decoration: InputDecoration(
//                       hintText: 'Họ',
//                       hintStyle: const TextStyle(color: Colors.black45),
//                       filled: true,
//                       fillColor: const Color(0xFFF6F7FB),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 16),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Email field
//                   TextField(
//                     controller: _email,
//                     decoration: InputDecoration(
//                       hintText: 'Email',
//                       hintStyle: const TextStyle(color: Colors.black45),
//                       filled: true,
//                       fillColor: const Color(0xFFF6F7FB),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 16),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Password field
//                   TextField(
//                     controller: _password,
//                     obscureText: _obscureText,
//                     decoration: InputDecoration(
//                       hintText: 'Mật khẩu',
//                       hintStyle: const TextStyle(color: Colors.black45),
//                       filled: true,
//                       fillColor: const Color(0xFFF6F7FB),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 16),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscureText ? Icons.visibility_off : Icons.visibility,
//                           color: Colors.black45,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscureText = !_obscureText;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//
//                   // Terms and Conditions text
//                   Center(
//                     child: RichText(
//                       textAlign: TextAlign.center,
//                       text: const TextSpan(
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 14,
//                         ),
//                         children: [
//                           TextSpan(
//                             text: 'Bằng việc đăng ký, bạn chấp nhận ',
//                           ),
//                           TextSpan(
//                             text: 'Điều khoản dịch vụ',
//                             style: TextStyle(
//                               color: Colors.blueAccent,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           TextSpan(
//                             text: ' và ',
//                           ),
//                           TextSpan(
//                             text: 'Chính sách quyền riêng tư',
//                             style: TextStyle(
//                               color: Colors.blueAccent,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           TextSpan(
//                             text: ' của Quizlet',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//
//                   // Create Account button
//                   state is SignupLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : ElevatedButton(
//                           onPressed:_onRegisterPressed,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFD9DEE8),
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text(
//                             'Tạo tài khoản',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.menu),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.check_box_outline_blank),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.arrow_back_ios_new),
//             label: '',
//           ),
//         ],
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         selectedItemColor: Colors.black45,
//         unselectedItemColor: Colors.black45,
//       ),
//     );
//   }
// }