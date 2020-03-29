import 'package:corona_trace/ui/widgets/CTQuestionPair.dart';
import 'package:flutter/material.dart';

import 'CTTermsAndConditions.dart';

class CTBottomSheetWidget extends StatelessWidget {
  const CTBottomSheetWidget(
      {this.mainQuestionText,
      this.subSectionDescription,
      this.questionPairWidget,
      this.onTermsConditionsClick});

  final String mainQuestionText;
  final String subSectionDescription;
  final CTQuestionPair questionPairWidget;
  final Function onTermsConditionsClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              mainQuestionText,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              subSectionDescription,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 25,
            ),
            questionPairWidget,
            SizedBox(
              height: 20,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            TermsAndConditions(onTermsConditionsClick: onTermsConditionsClick),
            SizedBox(
              height: 30,
            )
          ],
        )
      ],
    );
  }
}
