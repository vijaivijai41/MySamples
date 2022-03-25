import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;


bool get isIos =>
    foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

Widget equityBaseListContainer(Widget child) {
  return Container(
    decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1,
            spreadRadius: 0.0,
            offset: Offset(0, 0),
          )
        ]),
    padding: const EdgeInsets.only(top: 10),
    child: child,
  );
}