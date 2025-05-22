import 'package:fluro/fluro.dart';
import 'package:lingo_master/src/ui/features/home/component/search_page.dart';
import 'component/activity_page.dart';
import 'component/main_page.dart';
import 'component/search_all.dart';

class HomeRouter {
  static final Handler _homeHandler = Handler(
    handlerFunc: (context, parameters) => MainScreen(),
  );

  static final Handler _activityHandler = Handler(
    handlerFunc: (context, parameters) => ActivityScreen(),
  );
  static final Handler _searchHandler = Handler(
    handlerFunc: (context, parameters) => SearchScreen(),
  );
  static final Handler _searchAllHandler = Handler(
    handlerFunc: (context, parameters) => SearchALLScreen(),
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
      "/home",
      handler: _homeHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/activity",
      handler: _activityHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/search",
      handler: _searchHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/searchAll",
      handler: _searchAllHandler,
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