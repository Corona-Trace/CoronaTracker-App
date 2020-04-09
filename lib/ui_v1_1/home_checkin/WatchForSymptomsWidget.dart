import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

import 'home_confirm_not_sick.dart';

class WatchForSymptomsWidget extends StatelessWidget {
  final bool showBottomButtons;

  WatchForSymptomsWidget({this.showBottomButtons});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        children: <Widget>[
          SizedBox(height: 32),
          getWatchForSymptomsColumn(),
          getWhenToSeekMedical(),
          SizedBox(height: 20),
          getHowToProtect(),
          showBottomButtons ? bottomContent(context) : Container()
        ],
      ),),
    );
  }

  getWatchForSymptomsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            AppLocalization.text("watch.for.symptoms"),
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            child: Text(
              AppLocalization.text("this.guidance.was"),
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1A1D4A)),
            ),
            padding: EdgeInsets.only(top: 16),
          ),
        ),
        ListTile(
          title: Text(AppLocalization.text("these.symptoms.may.appear"),
              style: TextStyle(fontSize: 17, color: Color(0xff1A1D4A))),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text(
            "•  " + AppLocalization.text("Fever"),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          height: 0.5,
          indent: 20,
          color: Color(0xffBAC8E1),
        ),
        ListTile(
          title: Text(
            "•  " + AppLocalization.text("Cough"),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          height: 0.5,
          indent: 20,
          color: Color(0xffBAC8E1),
        ),
        ListTile(
          title: Text(
            "•  " + AppLocalization.text("shortness.breath"),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  getWhenToSeekMedical() {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            AppLocalization.text("when.seek.medical"),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(AppLocalization.text("if.you.develop"),
              style: TextStyle(fontSize: 17)),
          SizedBox(height: 10),
          ListTile(
            title: Text(
              "•  Trouble breathing",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 0.5,
            indent: 20,
            color: Color(0xffBAC8E1),
          ),
          ListTile(
            title: Text(
              "•  Persistent pain or pressure in the chest",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 0.5,
            indent: 20,
            color: Color(0xffBAC8E1),
          ),
          ListTile(
            title: Text(
              "•  New confusion or inability to around",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 0.5,
            indent: 20,
            color: Color(0xffBAC8E1),
          ),
          ListTile(
            title: Text(
              "•  Bluish lips or face",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      color: Color(0xffF3F4FC),
    );
  }

  getHowToProtect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            "Learn how to protect yourself",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          height: 0.5,
          color: Color(0xffBAC8E1),
          indent: 20,
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text("How to care for someone who is sick",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          height: 0.5,
          color: Color(0xffBAC8E1),
          indent: 20,
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text("What to do if you are sick",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          height: 0.5,
          color: Color(0xffBAC8E1),
          indent: 20,
        ),
      ],
    );
  }


  Widget bottomContent(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 30),
        Container(
          child: Material(
            child: MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width * 0.85,
              color: Color(0xff475DF3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                AppLocalization.text(
                  "next",
                ),
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeConfirmProcessSick(isSick: true,)));
              },
            ),
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
        Container(
          child: MaterialButton(
            height: 50,
            minWidth: MediaQuery.of(context).size.width * 0.85,
            color: Color(0xffDFE3FF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              AppLocalization.text(
                "go.back",
              ),
              style: TextStyle(color: Color(0xff475DF3), fontSize: 17),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          margin: EdgeInsets.only(bottom: 20),
        )
      ],
    );
  }
}