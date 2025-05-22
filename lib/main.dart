import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lingo_master/src/test/test_card_service.dart';
import 'package:lingo_master/src/test/test_card_user_service.dart';
import 'core/navigation/routers.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  AppRouter.setupRouter();
  runApp(MyApp());
  // runApp(MaterialApp(
  //   home: SimpleApiTestPage(),
  // ));
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
