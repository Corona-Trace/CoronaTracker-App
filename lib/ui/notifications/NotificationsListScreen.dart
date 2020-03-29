import 'package:corona_trace/main.dart';
import 'package:corona_trace/network/APIRepository.dart';
import 'package:corona_trace/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui/BaseState.dart';
import 'package:corona_trace/ui/CTCoronaTraceCommonHeader.dart';
import 'package:corona_trace/ui/CTStatusColor.dart';
import 'package:corona_trace/ui/notifications/CTNotificationMapDetail.dart';
import 'package:corona_trace/ui/notifications/CTNotificationsListWidget.dart';
import 'package:corona_trace/ui/screens/UserInfoCollectorScreen.dart';
import 'package:corona_trace/ui/widgets/CTHeaderTile.dart';
import 'package:corona_trace/utils/AppLocalization.dart';
import 'package:flutter/material.dart';

import 'CTNotificationItem.dart';

class NotificationsListScreen extends StatefulWidget {
  @override
  _NotificationsListScreenState createState() =>
      _NotificationsListScreenState();
}

class _NotificationsListScreenState extends BaseState<NotificationsListScreen> {
  @override
  void initState() {
    super.initState();
    PushNotifications.initStuff();
  }

  @override
  Widget prepareWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: <Widget>[
            CTCoronaTraceCommonHeader(),
            Expanded(
              child: Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Align(
                          child: Text(
                            AppLocalization.text("NOTIFICATIONS"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: CTNotificationsListWidget(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: updateYourStatus(),
                      width: MediaQuery.of(context).size.width,
                    ),
                    noSymptomsUpdate(context),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noSymptomsUpdate(BuildContext context) {
    return FutureBuilder(
        future: ApiRepository.getUserSeverity(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            Pair pair = getSymptomData(snapshot.data as int);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListTile(
                      title: Text(
                        pair.first,
                        style: TextStyle(
                            color: pair.second.first,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(AppLocalization.text("Anonymous.Status")),
                      leading: pair.second.second,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: MaterialButton(
                    color: Colors.indigo,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.indigo)),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UserInfoCollectorScreen()),
                          (route) => false);
                    },
                    child: Text(
                      AppLocalization.text("Update"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            );
          }
          return Container();
        });
  }

  Widget updateYourStatus() {
    return FutureBuilder(
        future: ApiRepository.getUserSeverity(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            int severity = snapshot.data as int;
            // severity = YES response from the user dont show this.
            if (severity == 1) {
              return Container();
            }
            return Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              color: Color.fromRGBO(241, 227, 178, 1),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
                child: Text(AppLocalization.text("Please.Update.Status")),
              ),
            );
          }
          return Container();
        });
  }
}
