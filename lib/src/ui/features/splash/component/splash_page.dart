import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/design_systems/theme/app_colors.dart';
import '../../../../../core/navigation/routers.dart';
import '../bloc/splash_bloc.dart';

class SplashProvider extends StatelessWidget {
  const SplashProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashBloc>(
      create: (context) => SplashBloc(),
      child: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      AppRouter.router.navigateTo(context, "/signin", replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Center(
        child: Image(
          image: AssetImage("assets/images/logo.png"),
        ),
      ),
    );
  }
}
