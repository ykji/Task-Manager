import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/presentations/custom/notes.dart';

class Notecard extends StatelessWidget {
  final Notes note;
  final VoidCallback onTap;
  Notecard({this.note, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(2)),
      height: ScreenUtil().setHeight(100),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: ScreenUtil().setWidth(15)),
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
                        fontSize: ScreenUtil().setSp(20))),
                Text(
                  note.date,
                  //style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Icon(Icons.open_in_new),
            onTap: onTap,
          ),
          SizedBox(width: ScreenUtil().setWidth(15)),
        ],
      ),
    );
  }
}
