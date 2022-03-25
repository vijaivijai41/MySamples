import 'package:flutter/material.dart';
import '../../EquityUtility/EQColor.dart';
import '../../EquityUtility/EQCommonWidget.dart';
import '../../EquityUtility/EQStatusText.dart';
import 'TransactionsWidgets/EQTradeBookWidget.dart';

class EQTransactionScene extends StatefulWidget {
  @override
  _EQTransactionScene createState() => _EQTransactionScene();
}

class _EQTransactionScene extends State<EQTransactionScene>
    with AutomaticKeepAliveClientMixin<EQTransactionScene> {
  @override
  Widget build(BuildContext context) {
    // MARK: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: EQColor.eqBGColor,
        body: transactionListView(context),
      ),
    );
  }

  Widget transactionListView(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.only(top: 10),
      itemBuilder: (context, index) => new Stack(children: [
        Card(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: equityBaseListContainer(EQTradeBookWidget())),
        EQStatusText('Executed', EQColor.eqGreenColor)
      ]),
    );
  }

  @override
  void initState() {
    // MARK: implement initState
    super.initState();
    print('Portfolio init state');
  }


  @override
  // MARK: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
