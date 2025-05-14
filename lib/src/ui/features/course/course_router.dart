import 'package:fluro/fluro.dart';
import 'package:lingo_master/src/ui/features/course/component/study/study_page.dart';
import 'package:lingo_master/src/ui/features/course/component/study/study_setting.dart';
import 'package:lingo_master/src/ui/features/course/component/test/test_page.dart';
import 'component/course_page.dart';
import 'component/memory_card/memory_card_page.dart';
import 'component/test/test_setting.dart';

class CourseRouter {
  static final Handler _maincourseHandler = Handler(
    handlerFunc: (context, parameters) => CourseScreen(),
  );
  static final Handler _memoryCardHandler = Handler(
    handlerFunc: (context, parameters) => MemoryCardScreen(),
  );
  static final Handler _studyHandler = Handler(
    handlerFunc: (context, parameters) => StudyScreen(),
  );
  static final Handler _studySettingHandler = Handler(
    handlerFunc: (context, parameters) => StudySetting(),
  );
  static final Handler _TestSettingHandler = Handler(
    handlerFunc: (context, parameters) => TestSetting(),
  );
  static final Handler _TestHandler = Handler(
    handlerFunc: (context, parameters) => TestScreen(),
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
      "/coursepage",
      handler: _maincourseHandler,
      transitionType: TransitionType.inFromRight,
    );
      router.define(
        "/memoryCard",
        handler: _memoryCardHandler,
        transitionType: TransitionType.inFromRight,
      );
    router.define(
      "/study",
      handler: _studyHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/studySetting",
      handler: _studySettingHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/testSetting",
      handler: _TestSettingHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/test",
      handler: _TestHandler,
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
