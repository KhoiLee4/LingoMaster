import 'package:fluro/fluro.dart';

import 'component/setting_page.dart';

class SettingRouter {
  static final Handler _settingHandler = Handler(
    handlerFunc: (context, parameters) => SettingScreen(),
  );

  // static final Handler _signinHandler = Handler(
  //   handlerFunc: (context, parameters) => SigninScreen(),
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
      "/setting",
      handler: _settingHandler,
      transitionType: TransitionType.inFromRight,
    );
    // router.define(
    //   "/signin",
    //   handler: _signinHandler,
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
