

import 'package:flutter/material.dart';
class EQWatchlistScene extends StatefulWidget {
  
  @override
  _EQWatchlistScene createState() => _EQWatchlistScene();
}


class _EQWatchlistScene extends State<EQWatchlistScene> with AutomaticKeepAliveClientMixin <EQWatchlistScene>{
 
  @override void initState() {
    // MARK: implement initState
    super.initState();
    print('init state watchlist');
  }

  @override
  Widget build(BuildContext context) {
    // MARH: implement build
    return MaterialApp(

      title: 'Watchlist',
      home: Scaffold(
        backgroundColor: Colors.red,),
      );
  }


  @override
  // MARK: implement wantKeepAlive
  bool get wantKeepAlive => false;

}