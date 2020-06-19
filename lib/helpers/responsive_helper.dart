import 'package:flutter/material.dart';

EdgeInsetsGeometry responsivePadding(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 700) {
    return EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  } else if (deviceWidth < 1200) {
    return EdgeInsets.symmetric(horizontal: 50, vertical: 25);
  } else if (deviceWidth < 1650) {
    return EdgeInsets.symmetric(horizontal: 80, vertical: 40);
  }
  return EdgeInsets.symmetric(horizontal: 100, vertical: 50);
}

int responsiveNumberOfTiles(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;

  if (deviceWidth < 700) {
    return 1;
  } else if (deviceWidth < 1200) {
    return 2;
  } else if (deviceWidth < 1650) {
    return 3;
  }
  return 4;
}

double responsiveImageHeight(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 700) {
    return 250;
  } else if (deviceWidth < 1200) {
    return deviceWidth * 0.25;
  } else if (deviceWidth < 1650) {
    return deviceWidth * 0.2;
  }
  return 0.15;
}

double responsiveTitleHeight(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 700) {
    return 120;
  } else if (deviceWidth < 1200) {
    return deviceWidth * 0.1;
  } else if (deviceWidth < 1650) {
    return deviceWidth * 0.07;
  }
  return 0.05;
}
