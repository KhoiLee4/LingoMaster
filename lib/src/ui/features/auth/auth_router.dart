import 'package:fluro/fluro.dart';
import 'component/forgotpassword_page.dart';
import 'component/signin_page.dart';
import 'component/signup_page.dart';
import 'component/success_verification_page.dart';
import 'component/wellcome_page.dart';


class AuthRouter {
  static final Handler _wellcomeHandler = Handler(
    handlerFunc: (context, parameters) => WellComeScreen(),
  );

  // static final Handler _signinHandler = Handler(
  //   handlerFunc: (context, parameters) => SigninScreen(),
  // );
  //
  // static final Handler _signupHandler = Handler(
  //   handlerFunc: (context, parameters) => SignupProvider(),
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
      "/wellcome",
      handler: _wellcomeHandler,
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
