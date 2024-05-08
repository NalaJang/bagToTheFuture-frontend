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

  static Widget arrowRight(
      {double width = 18, double height = 18, Color? color}) {
    return fromAsset('ic_right_arrow',
        width: width, height: height, color: color);
  }

  static Widget arrowDown(
      {double width = 11, double height = 5, Color? color}) {
    return fromAsset('ic_down_arrow_1',
        width: width, height: height, color: color);
  }

  static Widget arrowUp({double width = 16, double height = 16, Color? color}) {
    return fromAsset('ic_up_arrow_1',
        width: width, height: height, color: color);
  }

  static Widget headPhone(
      {double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_headset_microphone',
        width: width, height: height, color: color);
  }

  static Widget serviceFeedback(
      {double width = 23, double height = 23, Color? color}) {
    return fromAsset('service_feedback',
        width: width, height: height, color: color);
  }

  static Widget logo({double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_logo', width: width, height: height, color: color);
  }

  static Widget backToTheFutureTextLogo({double width = 142, double height = 114, Color? color}) {
    return fromAsset('ic_bttf_text_logo', width: width, height: height, color: color);
  }

  static Widget downArrow(
      {double width = 16, double height = 16, Color? color}) {
    return fromAsset('ic_down_arrow_1',
        width: width, height: height, color: color);
  }

  static Widget checked({double width = 20, double height = 20}) {
    return fromAsset('ic_checked', width: width, height: height);
  }

  static Widget unchecked({double width = 20, double height = 20}) {
    return fromAsset('ic_unchecked', width: width, height: height);
  }

  static Widget order({double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_order', width: width, height: height, color: color);
  }

  static Widget orderLogo(
      {double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_order_logo',
        width: width, height: height, color: color);
  }

  static Widget comment({double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_comment', width: width, height: height, color: color);
  }

  static Widget setting({double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_setting', width: width, height: height, color: color);
  }

  static Widget question(
      {double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_question', width: width, height: height, color: color);
  }

  static Widget info({double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_info', width: width, height: height, color: color);
  }

  static Widget reviewLeftStar(
      {double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_review_left_star',
        width: width, height: height, color: color);
  }

  static Widget reviewRightStar(
      {double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_review_right_star',
        width: width, height: height, color: color);
  }

  static Widget camera({double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_camera', width: width, height: height, color: color);
  }

  static Widget closeButton(
      {double width = 23, double height = 23, Color? color}) {
    return fromAsset('ic_close_button',
        width: width, height: height, color: color);
  }

  static Widget search(
      {required double width, required double height, required Color color}) {
    return fromAsset('ic_search', width: width, height: height, color: color);
  }

  static Widget locationPin(
      {required double width, required double height, required Color color}) {
    return fromAsset('ic_location', width: width, height: height, color: color);
  }

  static Widget delete(
      {required double width, required double height, required Color color}) {
    return fromAsset('ic_delete', width: width, height: height, color: color);
  }

  static Widget tagHome(
      {required double width, required double height, required Color color}) {
    return fromAsset('ic_taghome', width: width, height: height, color: color);
  }

  static Widget tagStar(
      {required double width, required double height, required Color color}) {
    return fromAsset('ic_star', width: width, height: height, color: color);
  }

  static Widget arrowDown_1(
      {required double width, required double height, required Color color}) {
    return fromAsset('ic_arrowDown',
        width: width, height: height, color: color);
  }

  static Widget enabledToggle(
      {double width = 51, double height = 31, Color? color}) {
    return fromAsset('ic_enabled_toggle',
        width: width, height: height, color: color);
  }

  static Widget disabledToggle(
      {double width = 51, double height = 31, Color? color}) {
    return fromAsset('ic_disabled_toggle',
        width: width, height: height, color: color);
  }

  static Widget gallery({double width = 51, double height = 31, Color? color}) {
    return fromAsset('ic_gallery', width: width, height: height, color: color);
  }

  static Widget backButton(
      {double width = 51, double height = 31, Color? color}) {
    return fromAsset('ic_back_button',
        width: width, height: height, color: color);
  }

  static Widget purpleBag({double width = 10, double height = 10, Color? color}) {
    return fromAsset(
        'ic_purple_bag', width: width, height: height, color: color);
  }

  static Widget home({double width = 24, double height = 24, Color? color}) {
    return fromAsset(
        'ic_home', width: width, height: height, color: color);
  }

  static Widget myFavorite({double width = 24, double height = 24, Color? color}) {
    return fromAsset(
        'ic_my_favorite', width: width, height: height, color: color);
  }

  static Widget myPage({double width = 24, double height = 24, Color? color}) {
    return fromAsset(
        'ic_my_page', width: width, height: height, color: color);
  }

  static Widget activatedHome({double width = 24, double height = 24, Color? color}) {
    return fromAsset(
        'ic_activated_home', width: width, height: height, color: color);
  }

  static Widget activatedMyFavorite({double width = 24, double height = 24, Color? color}) {
    return fromAsset(
        'ic_activated_my_favorite', width: width, height: height, color: color);
  }

  static Widget activatedMyPage({double width = 24, double height = 24, Color? color}) {
    return fromAsset(
        'ic_activated_my_page', width: width, height: height, color: color);
  }
}
