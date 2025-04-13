import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/design_systems/theme/app_colors.dart';
import '../../../../../core/navigation/routers.dart';

class WellComeScreen extends StatelessWidget {
  const WellComeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeaderImage(),
              const SizedBox(height: 20),
              _buildHeaderText(),
              const SizedBox(height: 16),
              _buildTermsText(),
              const SizedBox(height: 30),
              _buildGoogleLoginButton(),
              const SizedBox(height: 16),
              _buildEmailLoginButton(context),
              const SizedBox(height: 16),
              _buildLoginLink(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Image(
      height: 300,
      width: 300,
      image: AssetImage('assets/images/logo_welcome.png'),
    );
  }

  Widget _buildHeaderText() {
    return Text(
      'Cách tốt nhất để học. Đăng ký miễn phí.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2E3856),
      ),
    );
  }

  Widget _buildTermsText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          children: [
            const TextSpan(text: 'Bằng việc đăng ký, bạn chấp nhận '),
            TextSpan(
              text: 'Điều khoản dịch vụ',
              style: TextStyle(
                  color: Colors.blue[700], fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' và '),
            TextSpan(
              text: 'Chính sách quyền riêng tư',
              style: TextStyle(
                  color: Colors.blue[700], fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' của Quizlet'),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      height: 70,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: FaIcon(
          FontAwesomeIcons.google,
          color: AppColors.primaryWhite,
          size: 20,
        ),
        label: Text(
          'Tiếp tục với Google',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryWhite,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailLoginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      height: 70,
      child: OutlinedButton.icon(
        onPressed: () {
          AppRouter.router.navigateTo(context, "/signup", replace: true);
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppColors.neutralGray200,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(
          Icons.email_outlined,
          size: 30,
          color: AppColors.neutralGray600,
        ),
        label: const Text(
          'Đăng ký bằng email',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.neutralGray600,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Đã có tài khoản? ',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: () {
            AppRouter.router.navigateTo(context, "/signin", replace: true);
          },
          child: Text(
            'Đăng nhập',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
      ],
    );
  }
}
