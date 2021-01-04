import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_manager/presentations/note_list_screen.dart';

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
    return Center(child: CircularProgressIndicator());
  }

  timerFunction() {
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, NoteList.routeName);
    });
  }
}
