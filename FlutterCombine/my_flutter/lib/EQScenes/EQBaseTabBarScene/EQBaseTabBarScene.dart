



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:statefull_widget/EQScenes/EQWidgets/EQBaseTabBar.dart';

class EQBaseTabBarScene extends StatefulWidget {

  @override
  _EQBaseTabBarScene createState() => _EQBaseTabBarScene();

}

class _EQBaseTabBarScene extends State<EQBaseTabBarScene> {
 
 @override 
 void setState(fn) {
    // MARK: implement setState
    super.setState(fn);
  }
  @override 
  void initState() {
    // MARK: implement initState
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: 4,
        child: new Scaffold(
          body: EQBaseTabBar(),
        ),
      ),
    );
  }
}