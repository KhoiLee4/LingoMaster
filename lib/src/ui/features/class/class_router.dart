import 'package:fluro/fluro.dart';
import 'component/class_page.dart';

class ClassRouter {
  static final Handler _mainclassHandler = Handler(
    handlerFunc: (context, parameters) => ClassScreen(),
  );

  // static final Handler _achievementsHandler = Handler(
  //   handlerFunc: (context, parameters) => AchievementsScreen(),
  // );
  //
  // static final Handler _signupHandler = Handler(
  //   handlerFunc: (context, parameters) => RegisterScreen(),
  // );
  //
  // static final Handler _forgotHandler = Handler(
  //   handlerFunc: (context, parameters) => ForgotPasswordScreen(),
  // );
  //
  // static final Handler _verificationHandler = Handler(
  //   handlerFunc: (context, parameters) => EmailVerificationScreen(),
  // );

  static void defineRoutes(FluroRouter router) {
    router.define(
      "/classpage",
      handler: _mainclassHandler,
      transitionType: TransitionType.inFromRight,
    );
    // router.define(
    //   "/achievements",
    //   handler: _achievementsHandler,
    //   transitionType: TransitionType.inFromRight,
    // );
    // router.define(
    //   "/signup",
    //   handler: _signupHandler,
    //   transitionType: TransitionType.inFromRight,
    // );
    // router.define(
    //   "/forgot",
    //   handler: _forgotHandler,
    //   transitionType: TransitionType.inFromRight,
    // );
    // router.define(
    //   "/verification",
    //   handler: _verificationHandler,
    //   transitionType: TransitionType.inFromRight,
    // );
  }
}
