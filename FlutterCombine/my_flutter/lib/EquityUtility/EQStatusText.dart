
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'EQColor.dart';
import 'EQTextsWidget.dart';

class EQStatusText extends StatelessWidget {
  
  String textStr;
  EQColor statusColor;

  EQStatusText(String textStr ,EQColor statusColor) {
    this.textStr = textStr;
    this.statusColor = statusColor;
  }


  Widget lisStatusText(String text) {
    return Container(
        constraints: BoxConstraints(
          minWidth: 80.0,
          maxWidth: 100.0,
          minHeight: 30.0,
          maxHeight: 30.0,
        ),
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
              spreadRadius: 0.0,
              offset: Offset(0, 0),
            )
          ],
          borderRadius: new BorderRadius.circular(4.0),
          color: statusColor,
        ),
        margin: EdgeInsets.only(top: 10, left: 30),
        child: Center(
          child: EQTextWidget(text, EQTexts.listStatusText),
      ));
}

  @override
  Widget build(BuildContext context) {
    // MARK: implement build
    return lisStatusText(this.textStr);
  }
}
