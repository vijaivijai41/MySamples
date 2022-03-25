

import 'package:flutter/material.dart';
import 'package:statefull_widget/EQScenes/Profile/EQProfileScene.dart';
import 'package:statefull_widget/EQScenes/Watchlist/EQWatchlits.dart';
import 'package:statefull_widget/EQScenes/Portfolio/EQPortfolio.dart';
import 'package:statefull_widget/EQScenes/Transactions/EQTransactions.dart';
import 'package:statefull_widget/EquityUtility/EQColor.dart';
import 'package:statefull_widget/NavigationBar/EQNavigationBar.dart';





class EQBaseTabBar extends StatefulWidget {
  EQBaseTabBar({Key key}) : super(key :key);
  
  @override
  _EQBaseTabBar createState() => _EQBaseTabBar();

}


class _EQBaseTabBar extends State<EQBaseTabBar> {
  int tabBarIndex = 0;

  List<Widget> listScenes;

  @override void initState() {
    // MARK: implement initState
    super.initState();
  
    listScenes = [
      EQWatchlistScene(),
      EQTransactionScene(),
      EQPortfolioScene(),
      EQProfileScene(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // MARK: implement build
    var appBarWatchlist = EQNavigationBar('Watchlist');
    var appBarPortfolio = EQNavigationBar('Portfolio');
    var appBarTransactions = EQNavigationBar('Transactions');
    var appBarProfile = EQNavigationBar('Profile');

    EQNavigationBar _returnNavigationBar(int index) {
      switch (index) {
        case 0:
          return appBarWatchlist;
        case 1:
          return appBarTransactions;
        case 2:
        return appBarPortfolio;
        case 3:
        return appBarProfile;
      }
    }

    return MaterialApp(
      color: Colors.red,
      home: Scaffold(
        appBar: _returnNavigationBar(tabBarIndex),
        body:listScenes[tabBarIndex],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: EQColor.eqSelectionColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedLabelStyle: TextStyle(color: EQColor.eqBlackTextColor),
            selectedLabelStyle: TextStyle(color: EQColor.eqSelectionColor),
            selectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey[400],
            backgroundColor: Colors.white,
            currentIndex: tabBarIndex,
            onTap: (int index) {
              setState(() {
                tabBarIndex = index;
              });
            }, items: <BottomNavigationBarItem>[BottomNavigationBarItem(icon:Icon(Icons.home,color: Colors.grey[400]),activeIcon: Icon(Icons.home,color: Colors.blue),title: Text('Watchlist')),
            BottomNavigationBarItem(icon:Icon(Icons.edit,color: Colors.grey[400]),activeIcon: Icon(Icons.edit,color: Colors.blue),title: Text('Transaction')),
            BottomNavigationBarItem(icon:Icon(Icons.account_box,color: Colors.grey[400]),activeIcon: Icon(Icons.account_box,color: Colors.blue),title: Text('Portfolio')),
            BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.grey[400]),activeIcon: Icon(Icons.settings,color: Colors.blue),title: Text('Profile'))],
            
      ),
      backgroundColor: Colors.green,

      ),
    );
  }

}

class EQTextWidget {
}