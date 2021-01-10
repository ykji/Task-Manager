import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/presentations/note_list_screen.dart';
import 'package:task_manager/utils/string_values.dart';
import 'package:task_manager/utils/styles.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "SplashPage";
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timerFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.blueGrey[50],
              Colors.blueGrey,
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: ScreenUtil().setHeight(160)),
            Image(
              height: ScreenUtil().setHeight(100),

              // width: ScreenUtil().setWidth(100),
              image: AssetImage(Styles.appLogo),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Text(
              StringValue.appTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blueGrey[600],
                  fontSize: ScreenUtil().setSp(34),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: ScreenUtil().setHeight(60)),
            Text(
              StringValue.splashTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              child: Text(
                StringValue.splashText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(22),
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(60)),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  timerFunction() {
    Timer(Duration(seconds: 3), () {
      // Navigator.pop(context);
      Navigator.pushReplacementNamed(context, NoteList.routeName);
      // Navigator.pushReplacementNamed(
      //     context, CupertinoPageRoute(builder: (context) => NoteList()));
    });
  }
}
