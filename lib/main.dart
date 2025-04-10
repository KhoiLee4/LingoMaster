import 'package:flutter/material.dart';
import 'core/navigation/routers.dart';

void main() {
  AppRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lingo Master',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.router.generator,
      initialRoute: '/',
      // theme: ThemeData(
      //   textTheme: appTextTheme,
      // ),
    );
  }
}
