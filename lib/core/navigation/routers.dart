import 'package:fluro/fluro.dart';
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
  }
}
