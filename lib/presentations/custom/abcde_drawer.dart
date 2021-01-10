import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/utils/string_values.dart';
import 'package:task_manager/utils/styles.dart';

class DrawerABCDE extends StatelessWidget {
  int letter = 0;
  var meanings = [
    StringValue.aMean,
    StringValue.bMean,
    StringValue.cMean,
    StringValue.dMean,
    StringValue.eMean,
  ];
  var titles = [
    StringValue.a,
    StringValue.b,
    StringValue.c,
    StringValue.d,
    StringValue.e,
  ];
  showDialogBox(context, letter) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titles[letter], textAlign: TextAlign.center),
        content: Text(meanings[letter], textAlign: TextAlign.center),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("okay"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(25),
              vertical: ScreenUtil().setHeight(50)),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(4)),
              Image(
                height: ScreenUtil().setHeight(50),
                // width: ScreenUtil().setWidth(100),
                image: AssetImage(Styles.appLogo),
              ),
              SizedBox(height: ScreenUtil().setHeight(6)),
              Text(
                StringValue.whatAb,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: ScreenUtil().setHeight(4)),
              Text(
                StringValue.explainAb,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              drawerRow(title: StringValue.a, index: 0, context: context),
              Divider(thickness: ScreenUtil().setHeight(1)),
              drawerRow(title: StringValue.b, index: 1, context: context),
              Divider(thickness: ScreenUtil().setHeight(1)),
              drawerRow(title: StringValue.c, index: 2, context: context),
              Divider(thickness: ScreenUtil().setHeight(1)),
              drawerRow(title: StringValue.d, index: 3, context: context),
              Divider(thickness: ScreenUtil().setHeight(1)),
              drawerRow(title: StringValue.e, index: 4, context: context),
            ],
          ),
        ),
      ),
    );
  }

  drawerRow({String title, int index, context}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      child: InkWell(
        onTap: () {
          showDialogBox(context, index);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                // fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
