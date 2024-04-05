
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon {
  static Widget fromAsset(
      String iconName, {
        double width =  21,
        double height = 21,
        Color? color,
      }
  ) {
    final assetPath = 'assets/images/$iconName.svg';
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      color: color
    );
  }

  static Widget arrowLeft( {double width = 21, double height = 21, Color? color}) {
    return fromAsset('ic_arrow_left', width: width, height: height, color: color);
  }

}