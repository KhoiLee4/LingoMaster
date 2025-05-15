import 'package:fluro/fluro.dart';
import 'package:lingo_master/src/ui/features/course/component/matching_card/matching_card_ready.dart';
import 'package:lingo_master/src/ui/features/course/component/matching_card/matching_card_result.dart';
import 'package:lingo_master/src/ui/features/course/component/study/study_page.dart';
import 'package:lingo_master/src/ui/features/course/component/study/study_setting.dart';
import 'package:lingo_master/src/ui/features/course/component/test/test_page.dart';
import 'component/course_page.dart';
import 'component/matching_card/matchingCardSetting.dart';
import 'component/matching_card/matching_card.dart';
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
  static final Handler _MatchingCardReadyHandler = Handler(
    handlerFunc: (context, parameters) => MatchingCardReady(),
  );
  static final Handler _MatchingCardHandler = Handler(
    handlerFunc: (context, parameters) => MatchingCardScreen(),
  );
  static final Handler _MatchingCardResultHandler = Handler(
    handlerFunc: (context, parameters) => MatchingCardResult(),
  );
  static final Handler _MatchingCardSettingHandler = Handler(
    handlerFunc: (context, parameters) => MatchingCardSetting(),
  );


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
    router.define(
      "/matchingCardReady",
      handler: _MatchingCardReadyHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/matchingCard",
      handler: _MatchingCardHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/matchingCardResult",
      handler: _MatchingCardResultHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/matchingCardSetting",
      handler: _MatchingCardSettingHandler,
      transitionType: TransitionType.inFromRight,
    );
  }
}
