import 'package:fluro/fluro.dart';
import '../../src/ui/features/auth/auth_router.dart';
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

  static void setupRouter() {
    router.define(
      "/",
      handler: _splashHandler,
      transitionType: TransitionType.inFromRight,
    );
    AuthRouter.defineRoutes(router);
    HomeRouter.defineRoutes(router);
    LibraryRouter.defineRoutes(router);
    ProfileRouter.defineRoutes(router);
    SettingRouter.defineRoutes(router);
  }
}
