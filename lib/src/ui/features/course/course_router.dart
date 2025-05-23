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
import 'component/memory_card/memory_card_success.dart';
import 'component/study/study_success.dart';
import 'component/test/test_setting.dart';
import 'component/test/test_success.dart';

class CourseRouter {
  static final Handler _maincourseHandler = Handler(
    handlerFunc: (context, parameters) {
      final id = parameters['id']?.first;
      return CourseProvider(id: id);
    },
  );
  static final Handler _memoryCardHandler = Handler(
    handlerFunc: (context, parameters) {
      final id = parameters['id']?.first;
      return MemoryCardProvider(id: id);
    },
  );
  static final Handler _memoryCardSuccessHandler = Handler(
    handlerFunc: (context, parameters) => MemoryCardSuccess(),
  );
  static final Handler _studyHandler = Handler(
    handlerFunc: (context, parameters) {
      final id = parameters['id']?.first;
      return StudyProvider(id: id);
    },
  );
  static final Handler _studySettingHandler = Handler(
    handlerFunc: (context, parameters) => StudySetting(),
  );
  static final Handler _studySuccessHandler = Handler(
    handlerFunc: (context, parameters) => StudySuccess(),
  );
  static final Handler _TestSettingHandler = Handler(
    handlerFunc: (context, parameters) {
      final id = parameters['id']?.first;
      return TestSetting(id: id);
    },
  );
  static final Handler _TestHandler = Handler(
    handlerFunc: (context, parameters) {
      final id = parameters['id']?.first;
      return TestProvider(id: id);
    },
  );
  static final Handler _TestSuccessHandler = Handler(
    handlerFunc: (context, parameters) => TestSuccess(),
  );
  static final Handler _MatchingCardReadyHandler = Handler(
    handlerFunc: (context, parameters) {
      final id = parameters['id']?.first;
      return MatchingCardReady(id: id);
    },
  );
  static final Handler _MatchingCardHandler = Handler(
    handlerFunc: (context, parameters) {
      final id = parameters['id']?.first;
      return MatchingCardProvider(id: id);
    },
  );
  static final Handler _MatchingCardResultHandler = Handler(
    handlerFunc: (context, parameters) => MatchingCardResult(),
  );
  static final Handler _MatchingCardSettingHandler = Handler(
    handlerFunc: (context, parameters) => MatchingCardSetting(),
  );


  static void defineRoutes(FluroRouter router) {
    router.define(
      "/coursepage/:id",
      handler: _maincourseHandler,
      transitionType: TransitionType.inFromRight,
    );
      router.define(
        "/memoryCard/:id",
        handler: _memoryCardHandler,
        transitionType: TransitionType.inFromRight,
      );
    router.define(
      "/memoryCardSuccess",
      handler: _memoryCardSuccessHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/study/:id",
      handler: _studyHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/studySetting",
      handler: _studySettingHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/studySuccess",
      handler: _studySuccessHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/testSetting/:id",
      handler: _TestSettingHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/test/:id",
      handler: _TestHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/testSuccess",
      handler: _TestSuccessHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/matchingCardReady/:id",
      handler: _MatchingCardReadyHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/matchingCard/:id",
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
