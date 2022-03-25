import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:statefull_widget/EquityUtility/EQTextsWidget.dart';


class EQPositionsWidget extends StatelessWidget {
  // EquityOrderTradeBook bookInfo;

  // EQTradeBoolWidget(EquityOrderTradeBook bookInfo) {
  //   this.bookInfo = bookInfo;
  // }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(5),
        // First column
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              EQTextWidget('WIPRO',EQTexts.listSymbolText),
              EQTextWidget('NSE',EQTexts.exchangeText)
            ]),
            EQTextWidget('Price',EQTexts.listTitleText, )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              EQTextWidget('Wibro ltd',EQTexts.listValueText),
            ]),
            EQTextWidget('₹551.15',EQTexts.listValueText)
          ]),
        ]),
      ),

      Container(
        height: 0.5,
        margin: const EdgeInsets.only(top: 5.0, left: 0, right: 0, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.black26,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black12),
          ),
        ),
      ),

      // Second coloumn
      Container(
        padding: const EdgeInsets.all(5),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              EQTextWidget('Purchase value', EQTexts.listTitleText),
            ]),
            EQTextWidget('Latest value',EQTexts.listTitleText)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              EQTextWidget('₹24,551.15',EQTexts.listValueText),
            ]),
            EQTextWidget('₹25,551.15',EQTexts.listValueText)
          ]),
        ]),
      ),

      Container(
        height: 0.5,
        margin: const EdgeInsets.only(top: 5.0, left: 0, right: 0, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.black26,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black12),
          ),
        ),
      ),

      Container(
        padding: const EdgeInsets.all(5),
        child: // Third coloum
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              EQTextWidget('P&L',
                  EQTexts.listTitleText),
            ]),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              EQTextWidget('₹1000.00',
                  EQTexts.listValueTextWithStatus),
            ]),
          ]),
        ]),
      ),
    ]);
  }
}
