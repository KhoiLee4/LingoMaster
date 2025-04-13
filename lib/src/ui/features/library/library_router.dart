import 'package:fluro/fluro.dart';

import 'component/add_class_page.dart';
import 'component/add_course_page.dart';
import 'component/add_folder_page.dart';
import 'component/class_page.dart';
import 'component/course_page.dart';
import 'component/folder_page.dart';


class LibraryRouter {
  static final Handler _courseHandler = Handler(
    handlerFunc: (context, parameters) => CourseScreen(),
  );

  static final Handler _folderHandler = Handler(
    handlerFunc: (context, parameters) => FolderScreen(),
  );

  static final Handler _classHandler = Handler(
    handlerFunc: (context, parameters) => ClassScreen(),
  );

  static final Handler _newclassHandler = Handler(
    handlerFunc: (context, parameters) => NewClassScreen(),
  );

  static final Handler _newfolderHandler = Handler(
    handlerFunc: (context, parameters) => NewFolderScreen(),
  );

  static final Handler _newcourseHandler = Handler(
    handlerFunc: (context, parameters) => NewcourseScreen(),
  );

  static void defineRoutes(FluroRouter router) {
    router.define(
      "/course",
      handler: _courseHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/folder",
      handler: _folderHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/class",
      handler: _classHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/newclass",
      handler: _newclassHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/newfolder",
      handler: _newfolderHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/newcourse",
      handler: _newcourseHandler,
      transitionType: TransitionType.inFromRight,
    );
  }
}