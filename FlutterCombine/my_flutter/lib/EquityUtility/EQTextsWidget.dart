// create custom Text
import 'package:flutter/material.dart';
import 'package:statefull_widget/EQScenes/Portfolio/EQPortfolio.dart';
import 'package:statefull_widget/EquityUtility/EQColor.dart';

import 'EQColor.dart';

enum EQTexts {
  listSymbolText,
  listTitleText,
  listValueText,
  exchangeText,
  listStatusText,
  bottomBarText,
  listValueTextWithStatus

}

class EQTextWidget extends StatelessWidget {

  String textStr;
  EQTexts textType;

  EQTextWidget(String textStr, EQTexts textType) {
    this.textStr = textStr;
    this.textType = textType;
  }

   Widget textWidget(EQTexts type, String text) {
    switch (type) {
      case EQTexts.listSymbolText:
        print(text);
        return Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              text,
              style: TextStyle(
                  fontFamily: openSans,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700),
            ));

      case EQTexts.listTitleText:
        // MARK: Handle this case.
        return Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: openSans,color: EQColor.secondaryTextColor),
            ));

      case EQTexts.listValueText:
        // MARK: Handle this case.
        return Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Text(text,
              style: TextStyle(
                fontFamily: openSans,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              )),
        );

      case EQTexts.exchangeText:
        // MARK: Handle this case.
        return Container(
          padding: const EdgeInsets.fromLTRB(3, 2, 0, 0),
          child: Text(text,
              style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: openSans,
                  color: (text == 'NSE') ? EQColor.eqNseColor : EQColor.eqBseColor)),
        );
      case EQTexts.listStatusText:
        return Container(
          padding: const EdgeInsets.all(3),
          child: Text(text,
              style: TextStyle(
                  fontFamily: openSans,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        );

      case EQTexts.bottomBarText:
        return Container(
          padding: const EdgeInsets.all(3),
          child: Text(text,
              style: TextStyle(
                  fontFamily: openSans,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
        );

        case EQTexts.listValueTextWithStatus: 
        return Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Text(text,
              style: TextStyle(
                fontFamily: openSans,
                fontSize: 14.0,
                color: EQColor.eqGreenColor,
                fontWeight: FontWeight.w400,
              )),
        );

    }



  }
  

  @override
  Widget build(BuildContext context) {
    
    return textWidget(this.textType, this.textStr);
  }
}