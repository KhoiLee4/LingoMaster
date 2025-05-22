import 'package:fluro/fluro.dart';
import 'package:lingo_master/src/test/test_card_service.dart';
import '../../src/ui/features/auth/auth_router.dart';
import '../../src/ui/features/class/class_router.dart';
import '../../src/ui/features/course/course_router.dart';
import '../../src/ui/features/folder/folder_router.dart';
import '../../src/ui/features/home/home_router.dart';
import '../../src/ui/features/library/library_router.dart';
import '../../src/ui/features/profile/profile_router.dart';
import '../../src/ui/features/setting/setting_router.dart';
import '../../src/ui/features/splash/component/splash_page.dart';

class AppRouter {
  static final FluroRouter router = FluroRouter();

  static final Handler _splashHandler = Handler(
    handlerFunc: (context, parameters) => SplashProvider(),
  );
  static final Handler _testCardService = Handler(
    handlerFunc: (context, parameters) => SimpleApiTestPage(),
  );

  static void setupRouter() {
    router.define(
      "/",
      handler: _splashHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/testCardService",
      handler: _testCardService,
      transitionType: TransitionType.inFromRight,
    );
    AuthRouter.defineRoutes(router);
    // HomeRouter.defineRoutes(router);
    // LibraryRouter.defineRoutes(router);
    ClassRouter.defineRoutes(router);
    FolderRouter.defineRoutes(router);
    CourseRouter.defineRoutes(router);
    ProfileRouter.defineRoutes(router);
    SettingRouter.defineRoutes(router);
    
  }
}
