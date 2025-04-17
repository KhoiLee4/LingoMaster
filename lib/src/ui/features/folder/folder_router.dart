import 'package:fluro/fluro.dart';
import '../library/component/folder_page.dart';

class FolderRouter {
  static final Handler _mainfolderHandler = Handler(
    handlerFunc: (context, parameters) => FolderScreen(),
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
      "/folderpage",
      handler: _mainfolderHandler,
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
