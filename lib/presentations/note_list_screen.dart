import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/presentations/custom/custom_raised_buttton.dart';
import 'package:task_manager/presentations/custom/note_card.dart';
import 'package:task_manager/presentations/custom/screen_argument.dart';
import 'package:task_manager/presentations/note_detail_screen.dart';
import 'package:task_manager/utils/string_values.dart';

import 'custom/database_helper.dart';
import 'custom/notes.dart';

class NoteList extends StatefulWidget {
  static const routeName = "NoteList";
  @override
  NoteListState createState() => NoteListState();
}

class NoteListState extends State<NoteList> {
  DatabaseHelper helper = DatabaseHelper.getInstance();
  List<Notes> noteList = List<Notes>(); //error
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      this.noteList = List<Notes>();
      updateListViewVariables();
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(StringValue.appTitle),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            navigateToDetail(Notes('', '', 2), StringValue.addtask),
      ),
    );
  }

  void navigateToDetail(Notes note, String title) async {
    Navigator.pushNamed(context, NoteDetail.routeName,
            arguments: ScreenArgument(appBarTitle: title, note: note))
        .then((value) {
      if (value != null && value) {
        updateListViewVariables();
      }
    });
  }

  void updateListViewVariables() {
    final Future<Database> db = this.helper.initializeDatabase();
    // final Future<Database> db = this.helper.initializeDatabase();
    db.then((database) {
      Future<List<Notes>> noteListFuture = helper.getNoteList();
      noteListFuture.then((nL) {
        setState(() {
          this.noteList = nL;
          this.count = nL.length;
        });
      });
    });
  }

  _clear() async {
    print("in _clear");
    await this.helper.clear();
    this.updateListViewVariables();
  }

  getNoteListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: ScreenUtil().setHeight(4)),
        // notes list
        Expanded(
          child: ListView.builder(
              itemCount: this.count,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Notecard(
                  note: noteList[index],
                  onTap: () => {
                    navigateToDetail(
                        this.noteList[index], this.noteList[index].title)
                  },
                );
              }),
        ),
        // raised button for clearing all tasks
        Container(
          child: CustomRaisedButton(
            borderRadius: 30,
            buttonColor: Colors.grey[100],
            paddingVertical: 10,
            paddingHorizontal: 30,
            textColor: Colors.black,
            textSize: 20,
            childText: StringValue.clearWord,
            onPressed: () {
              print("clear click");
              setState(() {
                _clear();
              });
            },
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(14)),
      ],
    );
  }
}

// make custom text field
// make custom button
// key
