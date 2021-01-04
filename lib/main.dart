import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/presentations/note_detail_screen.dart';
import 'package:task_manager/presentations/note_list_screen.dart';
import 'package:task_manager/presentations/splash_page.dart';
import 'package:task_manager/utils/string_values.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  double defaultHeight = 812;
  double defaultWidth = 370;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(defaultWidth, defaultHeight),
      allowFontScaling: true,
      child: MaterialApp(
        title: StringValue.appTitle,
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (BuildContext context) => SplashPage(),
          NoteList.routeName: (BuildContext context) => NoteList(),
          NoteDetail.routeName: (BuildContext context) => NoteDetail(),
          // HomePage.routeName: (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}
