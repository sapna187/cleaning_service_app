import 'package:flutter/material.dart';


class AppSizes {
  AppSizes._(); 

  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    final media = MediaQuery.of(context);
    screenWidth = media.size.width;
    screenHeight = media.size.height;
  }
  static double scaleWidth(double size) => (size / 375) * screenWidth;
  static double scaleHeight(double size) => (size / 812) * screenHeight;

  /// Standard responsive sizes
  static double size4 = scaleWidth(4);
  static double size12 = scaleWidth(12);
  static double size16 = scaleWidth(16);
  static double size35 = scaleWidth(35);
  static double size40 = scaleWidth(40);
  static double size50 = scaleWidth(50);
  static double size100 = scaleWidth(100);
  static double size150 = scaleWidth(150);
  static double size200 = scaleWidth(200);

  // Padding / Margin
  static double paddingSmall = scaleWidth(8);
  static double paddingMedium = scaleWidth(16);
  static double paddingLarge = scaleWidth(24);

  static double marginSmall = scaleWidth(8);
  static double marginMedium = scaleWidth(16);
  static double marginLarge = scaleWidth(24);

  // Spacing between widgets
  static double spaceXS = scaleWidth(4);
  static double spaceS = scaleWidth(8);
  static double spaceM = scaleWidth(16);
  static double spaceL = scaleWidth(24);
  static double spaceXL = scaleWidth(32);

  // Border Radius
  static double radiusSmall = scaleWidth(6);
  static double radiusMedium = scaleWidth(12);
  static double radiusLarge = scaleWidth(20);

  // Icon Sizes
  static double iconSmall = scaleWidth(16);
  static double iconMedium = scaleWidth(24);
  static double iconLarge = scaleWidth(32);

  // Font Sizes
  static double fontSmall = scaleWidth(12);
  static double fontMedium = scaleWidth(14);
  static double fontLarge = scaleWidth(18);
  static double fontXLarge = scaleWidth(20);

  // Button Height
  static double buttonHeight = scaleHeight(48);

  // Gap Helpers (useful for spacing in Column/Row)
  static Widget verticalGap(double height) => SizedBox(height: height);
  static Widget horizontalGap(double width) => SizedBox(width: width);

  // Predefined Gap Widgets for quick use
  static Widget vSpaceS = verticalGap(spaceS);
  static Widget vSpaceM = verticalGap(spaceM);
  static Widget vSpaceL = verticalGap(spaceL);

  static Widget hSpaceS = horizontalGap(spaceS);
  static Widget hSpaceM = horizontalGap(spaceM);
  static Widget hSpaceL = horizontalGap(spaceL);
}
