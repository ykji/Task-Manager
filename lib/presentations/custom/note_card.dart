import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/presentations/custom/notes.dart';

class Notecard extends StatelessWidget {
  static var _priorityOption = ['A', 'B', 'C', 'D', 'E'];
  final Notes note;
  final VoidCallback onTap;
  Notecard({this.note, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(2)),
      padding : EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(12)),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: ScreenUtil().setHeight(33),
              backgroundImage:
                  NetworkImage('https://learncodeonline.in/mascot.png'),
            ),
            SizedBox(width: ScreenUtil().setWidth(15)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(note.title ?? " ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(22))),
                  Text(
                    note.date,
                    style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                  ),
                  Text(
                    "Priority - ${_priorityOption[note.priority - 1]}",
                    style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Icon(Icons.open_in_new),
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
