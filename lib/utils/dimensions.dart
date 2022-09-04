import 'package:flutter/material.dart';

class Dimensions {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  static double pageView = screenHeight! / 2.64;
  static double pageViewContainer = screenHeight! / 3.84;
  static double pageViewTextContainer = screenHeight! / 7.03;
  //dynamic height padding and margin
  static double height10 = screenHeight! / 84.4;
  static double height15 = screenHeight! / 56.27;
  static double height20 = screenHeight! / 42.2;
  static double height30 = screenHeight! / 28.13;
  static double height45 = screenHeight! / 18.76;
  //dynamic width padding and margin
  static double width10 = screenHeight! / 84.4;
  static double width15 = screenHeight! / 56.27;
  static double width20 = screenHeight! / 42.2;
  static double width30 = screenHeight! / 28.13;

  //font size
  static double font16 = screenHeight! / 52.75;
  static double font20 = screenHeight! / 42.2;
  static double font26 = screenHeight! / 32.46;

  //list view size
  static double listViewImgSize = screenWidth! / 3.25;
  static double listViewTextContSize = screenWidth! / 3.9;

  //popular food
  static double popularFoodImgSize = screenHeight! / 2.41;

  //splash screen dimensions
  static double splashImg = screenHeight! / 3.38;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
  }
}
