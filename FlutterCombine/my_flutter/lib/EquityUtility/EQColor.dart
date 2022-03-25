

import 'package:flutter/material.dart';

class EQColor extends Color {

  static Color eqBGColor =  EQColor('F6F7FB');
  static Color btstColor =  EQColor('D87365');
 
  static Color cancelOrder =  EQColor('659ED8');
  static Color delivery =  EQColor('55BE65');
  static Color eqBlackTextColor =  EQColor('383838');
  static Color eqBlueButtonColor =  EQColor('4A7BFF');
  static Color eqBorderColor =  EQColor('3C3C43');
  static Color eqBseColor =  EQColor('EA9954');
  static Color eqDarkGrayButtonColor =  EQColor('E3E3E3');
  static Color eqFilterTextColor =  EQColor('505050');
  static Color eqGrayButtonColor =  EQColor('F0F0F0');
  static Color eqGreenColor =  EQColor('55BE65');
  static Color eqNavigationBarColor =  EQColor('FBFBFB');
  static Color eqNFOColor =  EQColor('868686');
  static Color eqNoChangeColor =  EQColor('A3A6B4');
  static Color eqNseColor =  EQColor('0084FF');
  static Color eqRedColor =  EQColor('D87365');

  static Color eqSelectionColor =  EQColor('4A7BFF');
  static Color executeOrder =  EQColor('55BE65');

  static Color fnoColor =  EQColor('DEC747');
  static Color intradayColor =  EQColor('EA9954');
  static Color marginColor =  EQColor('659ED8');
  static Color modifiedOrderColor =  EQColor('BABABA');
  static Color pendingOrderColor =  EQColor('EA9954');
  static Color rejectOrderColor =  EQColor('3C3C43');

  static Color secondaryTextColor =  EQColor('3C3C43');
  static Color t1Color =  EQColor('BABABA');


  static int _getcolorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor,radix: 16);

  }
  EQColor(final String hexColor) : super(_getcolorFromHex(hexColor));
}



