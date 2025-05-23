import 'package:fluro/fluro.dart';

import 'component/class/add_class_page.dart';
import 'component/course/add_course_page.dart';
import 'component/folder/add_folder_page.dart';
import 'component/class/class_tab.dart';
import 'component/course/course_tab.dart';
import 'component/folder/folder_tab.dart';
import 'component/library_page.dart';


class LibraryRouter {
  static final Handler _libraruHandler = Handler(
    handlerFunc: (context, parameters) => LibraryScreen(),
  );
  static final Handler _addCourseHandler = Handler(
    handlerFunc: (context, parameters) => AddHocPhanScreen(),
  );
  static final Handler _addFolderHandler = Handler(
    handlerFunc: (context, parameters) => AddThuMucScreen(),
  );
  static final Handler _addClassHandler = Handler(
    handlerFunc: (context, parameters) => AddLopHocScreen(),
  );
  // static final Handler _courseHandler = Handler(
  //   handlerFunc: (context, parameters) => CourseScreen(),
  // );
  //
  // static final Handler _folderHandler = Handler(
  //   handlerFunc: (context, parameters) => FolderScreen(),
  // );
  //
  // static final Handler _classHandler = Handler(
  //   handlerFunc: (context, parameters) => ClassScreen(),
  // );
  //
  // static final Handler _newclassHandler = Handler(
  //   handlerFunc: (context, parameters) => NewClassScreen(),
  // );
  //
  // static final Handler _newfolderHandler = Handler(
  //   handlerFunc: (context, parameters) => NewFolderScreen(),
  // );
  //
  // static final Handler _newcourseHandler = Handler(
  //   handlerFunc: (context, parameters) => NewcourseScreen(),
  // );

  static void defineRoutes(FluroRouter router) {
    router.define(
      "/library",
      handler: _libraruHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/addCourse",
      handler: _addCourseHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/addFolder",
      handler: _addFolderHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      "/addClass",
      handler: _addClassHandler,
      transitionType: TransitionType.inFromRight,
    );
    // router.define(
    //   "/library/course",
    //   handler: _courseHandler,
    //   transitionType: TransitionType.inFromRight,
    // );
    // router.define(
    //   "/library/folder",
    //   handler: _folderHandler,
    //   transitionType: TransitionType.inFromRight,
    // );
    // router.define(
    //   "/library/class",
    //   handler: _classHandler,
    //   transitionType: TransitionType.inFromRight,
    // );
    // router.define(
    //   "/library/newclass",
    //   handler: _newclassHandler,
    //   transitionType: TransitionType.inFromRight,
    // );
    // router.define(
    //   "/library/newfolder",
    //   handler: _newfolderHandler,
    //   transitionType: TransitionType.inFromRight,
    // );
    // router.define(
    //   "/library/newcourse",
    //   handler: _newcourseHandler,
    //   transitionType: TransitionType.inFromRight,
    // );
  }
}