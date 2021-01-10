import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/presentations/custom/abcde_drawer.dart';
import 'package:task_manager/presentations/custom/custom_raised_buttton.dart';
import 'package:task_manager/presentations/custom/custom_textfield.dart';
import 'package:task_manager/presentations/custom/screen_argument.dart';
import 'package:task_manager/utils/string_values.dart';
import 'custom/notes.dart';
import 'custom/database_helper.dart';

class NoteDetail extends StatefulWidget {
  static const String routeName = "NoteDetail";

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState();
  }
}

class NoteDetailState extends State<NoteDetail> {
  static var _priorityOption = ['A', 'B', 'C', 'D', 'E'];
  DatabaseHelper helper = DatabaseHelper.getInstance();
  String appBarTitle;
  Notes note;
  TextStyle textStyle;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(context) {
    if (appBarTitle == null) {
      ScreenArgument argument = ModalRoute.of(context).settings.arguments;
      appBarTitle = argument.appBarTitle;
      note = argument.note;
      textStyle = Theme.of(context).textTheme.headline6;
      titleController.text = note.title;
      descriptionController.text = note.description;
    }

    return WillPopScope(
        onWillPop: moveToLastScreen,
        child: Scaffold(
          drawer: DrawerABCDE(),
          backgroundColor: Colors.blueGrey[100],
          appBar: AppBar(
            centerTitle: true,
            title: Text(appBarTitle),
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: moveToLastScreen,
            // ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(50),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.low_priority),
                    title: DropdownButton(
                        items: _priorityOption.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem,
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(25),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue)),
                          );
                        }).toList(),
                        value: getPriority(note.priority),
                        onChanged: (valueSelectedByUser) {
                          setState(() {
                            updatePriorityAsInt(valueSelectedByUser);
                          });
                        }),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  // Second Element
                  CustomTextField(
                    controller: titleController,
                    textStyle: textStyle,
                    onChanged: (value) {
                      updateTitle();
                    },
                    icon: Icon(Icons.title),
                    labelText: StringValue.colTitle,
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  // Third Element
                  CustomTextField(
                    controller: descriptionController,
                    textStyle: textStyle,
                    onChanged: (value) {
                      updateDescription();
                    },
                    icon: Icon(Icons.details),
                    labelText: StringValue.detailWord,
                  ),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  // Fourth Element
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: CustomRaisedButton(
                          borderRadius: 30,
                          buttonColor: Colors.green[300],
                          paddingVertical: 8,
                          paddingHorizontal: 25,
                          childText: StringValue.saveWord,
                          textColor: Colors.white,
                          textSize: 20,
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        child: CustomRaisedButton(
                          borderRadius: 30,
                          buttonColor: Colors.red[300],
                          paddingVertical: 8,
                          paddingHorizontal: 25,
                          childText: StringValue.deleteWord,
                          textColor: Colors.white,
                          textSize: 20,
                          onPressed: () {
                            setState(() {
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _showAlertDialog(String title, String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.transparent,
        textColor: Colors.black,
        fontSize: ScreenUtil().setSp(20));
  }

  _save() async {
    moveToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    var result;
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      if (note.id != null) {
        result = await helper.updateNote(note);
      } else {
        result = await helper.insertNote(note);
      }
    }

    print(result);
    if (result != null && result != 0)
      _showAlertDialog('Status', 'Note Saved Successfully');
    else
      _showAlertDialog('Status', 'Note not Saved.\nAll fields are required.');
  }

  _delete() async {
    moveToLastScreen();
    if (note.id == null) {
      _showAlertDialog('Status', "Note doesn't exist.");
      return;
    }

    var result = await helper.deleteNote(note.id);
    if (result != null)
      _showAlertDialog('Status', 'Note Deleted Successfully');
    else
      _showAlertDialog('Status', 'Problem! Try Again');
  }

  Future<bool> moveToLastScreen() async {
    Navigator.pop(context, true);
    return false;
  }

  void updatePriorityAsInt(String val) {
    if (val == 'A')
      note.priority = 1;
    else if (val == 'B')
      note.priority = 2;
    else if (val == 'C')
      note.priority = 3;
    else if (val == 'D')
      note.priority = 4;
    else
      note.priority = 5;
  }

//getting data from database,so converting it into high/low for user
  String getPriority(int val) {
    return _priorityOption[val - 1];
  }
}
