import 'package:fluro/fluro.dart';
import 'component/achievements_page.dart';
import 'component/proflie_page.dart';

class ProfileRouter {
  static final Handler _profileHandler = Handler(
    handlerFunc: (context, parameters) => ProfileScreen(),
  );

  static final Handler _achievementsHandler = Handler(
    handlerFunc: (context, parameters) => AchievementsScreen(),
  );
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
      "/profile",
      handler: _profileHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/achievements",
      handler: _achievementsHandler,
      transitionType: TransitionType.inFromRight,
    );
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
