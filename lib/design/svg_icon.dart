import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon {
  static Widget fromAsset(
    String iconName, {
    double width = 21,
    double height = 21,
    Color? color,
  }) {
    final assetPath = 'assets/images/$iconName.svg';
    return SvgPicture.asset(assetPath,
        width: width, height: height, color: color);
  }

  static Widget arrowLeft(
      {double width = 21, double height = 21, Color? color}) {
    return fromAsset('ic_arrow_left',
        width: width, height: height, color: color);
  }

  static Widget headPhone(
      {double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_headset_microphone',
        width: width, height: height, color: color);
  }

  static Widget logo({double width = 23, double height = 23, Color? color}) {
    return fromAsset('logo', width: width, height: height, color: color);
  }

  static Widget order({double width = 23, double height = 23, Color? color}) {
    return fromAsset('order', width: width, height: height, color: color);
  }

  static Widget comment({double width = 23, double height = 23, Color? color}) {
    return fromAsset('comment', width: width, height: height, color: color);
  }

  static Widget setting({double width = 23, double height = 23, Color? color}) {
    return fromAsset('setting', width: width, height: height, color: color);
  }

  static Widget question(
      {double width = 23, double height = 23, Color? color}) {
    return fromAsset('question', width: width, height: height, color: color);
  }

  static Widget info({double width = 23, double height = 23, Color? color}) {
    return fromAsset('info', width: width, height: height, color: color);
  }

  static Widget enabledToggle({double width = 51, double height = 31, Color? color}) {
    return fromAsset('ic_enabled_toggle', width: width, height: height, color: color);
  }

  static Widget disabledToggle({double width = 51, double height = 31, Color? color}) {
    return fromAsset('ic_disabled_toggle', width: width, height: height, color: color);
  }
}
