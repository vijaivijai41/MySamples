import 'package:flutter/material.dart';
import '../EquityUtility/EQCommonWidget.dart';
import 'package:flutter/cupertino.dart';


class EQNavigationBar extends StatelessWidget with PreferredSizeWidget {

  String titleStr;

  EQNavigationBar(String titleStr) {
    this.titleStr = titleStr;
  }

  void setTitle(String title) {
    this.titleStr = title;
  }

  CupertinoNavigationBar iosNavigationBar(String titleStr) {
    return  CupertinoNavigationBar(
    automaticallyImplyMiddle: true,middle: Text(titleStr),
    trailing: Container(width: 80,child: Row(mainAxisAlignment: MainAxisAlignment.end, 
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [IconButton(
          icon: new Icon(
            Icons.whatshot,
            size: 30.0,
            color: Colors.black,
          ),
          padding: const EdgeInsets.only(left: 5.0),
          alignment: Alignment.center,
          tooltip: 'Air it',
          onPressed: () {},
        ),
        IconButton(
          icon: new Icon(
            Icons.search,
            size: 30.0,
            color: Colors.black,
          ),
          padding: const EdgeInsets.only(right: 10.0),
          alignment: Alignment.center,
          tooltip: 'Air it',
          onPressed: () {},
        )
      ]),) ,
      backgroundColor: Colors.white);
  }

  AppBar materialNavigationBar(String title) {
   return  AppBar(title: Text(titleStr,style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)),leading: new IconButton(
    icon: new Icon(Icons.dehaze, color: Colors.black),
    onPressed: (){},

  ) ,actions:[IconButton(
        icon: new Icon(Icons.whatshot, size:30.0,color: Colors.black, ),
        padding: const EdgeInsets.only(right: 10.0),
        alignment: Alignment.center,
        tooltip: 'Air it',
        onPressed: (){},
    ),
    IconButton(
        icon: new Icon(Icons.search, size:30.0,color: Colors.black, ),
        padding: const EdgeInsets.only(right: 10.0),
        alignment: Alignment.center,
        tooltip: 'Air it',
        onPressed: (){},
    )
],centerTitle: true,automaticallyImplyLeading: true, backgroundColor: Colors.white,);
  }

  @override
  Widget build(BuildContext context) {
    // MARK: implement build
     if (isIos) {
        return iosNavigationBar(this.titleStr);
     } else {
       return materialNavigationBar(this.titleStr);
     }
    
  }

  @override
  // MARK: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}