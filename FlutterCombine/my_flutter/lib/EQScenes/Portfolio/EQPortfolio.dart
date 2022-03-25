import 'package:flutter/material.dart';
import 'package:statefull_widget/EquityUtility/EQColor.dart';
import 'package:statefull_widget/EquityUtility/EQStatusText.dart';
import 'package:statefull_widget/EquityUtility/EQCommonWidget.dart';
import '../../EquityUtility/EQColor.dart';
import 'PortfolioWidget/EQPositionWidget.dart';

const String openSans = 'OpenSans';

class EQPortfolioScene extends StatefulWidget {
  @override
  _EQPortfolioScene createState() => _EQPortfolioScene();
}

class _EQPortfolioScene extends State<EQPortfolioScene>
    with AutomaticKeepAliveClientMixin<EQPortfolioScene> {
  @override
  
  Widget build(BuildContext context) {
    // MARK: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: EQColor.eqBGColor,
        body: portfolioListView(context),
      ),
    );
  }

  Widget portfolioListView(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.only(top: 10),
      itemBuilder: (context, index) => new Stack(children: [
        Card(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: equityBaseListContainer(EQPositionsWidget())),
            Expanded(child: EQStatusText('FNO',EQColor.btstColor))
            
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
  // MARK: implement keptAlive
  bool get wantKeepAlive => false;
}



