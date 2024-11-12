import 'package:flutter/material.dart';

extension ResponsiveExtensions on BuildContext {
  // Get the screen width
  double get screenWidth => MediaQuery.of(this).size.width;
  Size get screenSize => MediaQuery.of(this).size;

  // Get the screen height
  double get screenHeight => MediaQuery.of(this).size.height;
  // Get the screen orientation
  Orientation get orientation => MediaQuery.of(this).orientation;
  // Get responsive width based on a percentage
  double responsiveWidth(double percentage) {
    return (screenWidth * percentage) / 100;
  }

  double responsiveSize(double percentage) {
    return ((screenSize.width * percentage) / 100);
  }

  // Get responsive height based on a percentage
  double responsiveHeight(double percentage) {
    return (screenHeight * percentage) / 100;
  }

  // Get responsive font size based on a factor
  double responsiveFontSize(
      BuildContext context, double mobileFontSize, double desktopFontSize) {
    return context.isMobile ? mobileFontSize : desktopFontSize;
  }

  bool get isMobile => MediaQuery.of(this).size.width <= 600;
  bool get isTablet =>
      MediaQuery.of(this).size.width > 600 &&
      MediaQuery.of(this).size.width <= 1024;
  bool get isDesktop =>
      MediaQuery.of(this).size.width > 1024 &&
      MediaQuery.of(this).size.width <= 1400;
  bool get isLargeDesktop => MediaQuery.of(this).size.width > 1920;
}
