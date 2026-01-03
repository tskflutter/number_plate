import 'package:flutter/material.dart';

class MyColor {
  // ===================== Neutral Colors =====================
  static const Color transparent = Colors.transparent;
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // ===================== Light Theme Colors =====================
  // Primary & Secondary
  static const Color lightPrimary = Color(0xFF1A1F25);
  static const Color lightSecondary = Color(0xFF0466C8);

  // Text Colors
  static const Color lightHeadingText = Color(0xFF1E293B);
  static const Color hintTextColor = Color(0xFF808283);
  static const Color lightBodyText = Color(0xFF475569);
  static const Color primaryTextColor = Color(0xff171818);
  static const Color contentTextColor = Color(0xffD1D5DC);

  // Accent Colors
  static const Color lightAccent1 = Color(0xFF77AAFF);

  // Section & Background
  static const Color lightBackground = Color(0xFFf3f5f6); // Light Background
  static const Color lightCardBackground = Color(0xFFFFFFFF); // Card Background
  static const Color plateBgColor = Color(0xFFE9ECEF); // Card Background
  static const Color lightTextFieldBackground = Color(0xFFF3F5F6); // textfield Background
  static const Color lightSectionBackground = Color(0xFFF8FAFC); // Section Background
  static const Color lightScaffoldBackground = Color(0xFFF8FAFC); // Scaffold Background
  static const Color lightAppBarBackground = Color(0xFFF8FAFC); // Dark AppBar background
  static const Color greenColor = Color(0xFF00a63e); // green background
  static const Color greenColorShadow = Color(0xFF009939); // green shadow
  static const Color blackColorShadow = Color(0xFF444545); //black background
  static const Color orangeShade = Color(0xFFFFB900); //pay now structure card background
  static const Color greenShade = Color(0xFF05DF72); //pay now structure card background
  // Borders
  static const Color lightBorder = Color(0xFFB6B8BA);
  static const Color lightTextFieldBorder = Color(0xFFEEF0F3);
  static const Color dropDownFieldBorder = Color(0xFFDBDBDB);
  static const Color dividerColor = Color(0xFF818487);
  static const Color cardInactiveBorderColor = Color(0xFFC7C7C7);

  // Feedback Colors
  static const Color lightInformation = Color(0xFF007AFF);
  static const Color lightWarning = Color(0xFFFFCC00);
  static const Color lightSuccess = Color(0xFF198754);
  static const Color lightError = Color(0xFFEB4E3D);

  // Button Colors
  static const Color lightButtonBackground = lightPrimary;
  static const Color lightButtonText = white;

  // ===================== Dark Theme Colors =====================
  // Primary & Secondary
  static const Color darkPrimary = Color(0xFFFF5722); // A slightly muted orange for dark mode
  static const Color darkSecondary = Color(0xFF1E88E5); // A deeper blue for contrast

  // Text Colors
  static const Color headingTextColor = Color(0xFF171818); // Almost white for headings
  static const Color darkBodyText = Color(0xFFFFFFFF); // Light gray for body text

  // Accent Colors
  static const Color darkAccent1 = Color(0xFF64B5F6); // Soft blue accent
  static const Color greenAccent = Color(0xFF09321F); // Soft blue accent

  // Section & Background
  static const Color darkBackground = Color(0xFF121212); // Dark mode background
  static const Color darkCardBackground = Color(0xFF1E1E1E); // Slightly lighter card background
  static const Color darkSectionBackground = Color(0xFF232323); // For sections
  static const Color darkScaffoldBackground = Color(0xFF121212); // Dark scaffold background
  static const Color darkAppBarBackground = Color(0xFF232323); // Dark AppBar background
  static const Color boostButtonBg = Color(0xFFD0F6E4); // boost button background

  // Borders
  static const Color darkBorder = Color(0xFFB6B8BA); // Subtle dark border

  // Feedback Colors
  static const Color darkInformation = Color(0xFF0466C8); // Lighter green for better visibility
  static const Color darkWarning = Color(0xFFFFCA28); // A vibrant amber for warnings
  static const Color darkSuccess = Color(0xFF43A047); // Slightly darker green for success
  static const Color darkError = Color(0xFFDC3545); // Vibrant red for errors

  // Button Colors
  static const Color darkButtonBackground = darkPrimary;
  static const Color darkButtonText = white; // Black text for better visibility on buttons

  //All Colors getters
// ===================== Getters for Colors =====================
  static Color getTransparentColor({bool isLightTheme = true}) => transparent;
  static Color getPrimaryColor({bool isLightTheme = true}) => isLightTheme ? lightPrimary : darkPrimary;
  static Color getSecondaryColor({bool isLightTheme = true}) => isLightTheme ? lightSecondary : darkSecondary;
  static Color getHeadingTextColor({bool isLightTheme = true}) => isLightTheme ? lightHeadingText : headingTextColor;
  static Color getBodyTextColor({bool isLightTheme = true}) => isLightTheme ? lightBodyText : darkBodyText;
  static Color getAccent1Color({bool isLightTheme = true}) => isLightTheme ? lightAccent1 : darkAccent1;
  static Color getBackgroundColor({bool isLightTheme = true}) => isLightTheme ? lightBackground : darkBackground;
  static Color getCardBackgroundColor({bool isLightTheme = true}) => isLightTheme ? lightCardBackground : darkCardBackground;
  static Color getSectionBackgroundColor({bool isLightTheme = true}) => isLightTheme ? lightSectionBackground : darkSectionBackground;
  static Color getScaffoldBackgroundColor({bool isLightTheme = true}) => isLightTheme ? lightScaffoldBackground : darkScaffoldBackground;
  static Color getBorderColor({bool isLightTheme = true}) => isLightTheme ? lightBorder : darkBorder;
  static Color getInformationColor({bool isLightTheme = true}) => isLightTheme ? lightInformation : darkInformation;
  static Color getWarningColor({bool isLightTheme = true}) => isLightTheme ? lightWarning : darkWarning;
  static Color getSuccessColor({bool isLightTheme = true}) => isLightTheme ? lightSuccess : darkSuccess;
  static Color getErrorColor({bool isLightTheme = true}) => isLightTheme ? lightError : darkError;
  static Color getButtonBackgroundColor({bool isLightTheme = true}) => isLightTheme ? lightButtonBackground : darkButtonBackground;
  static Color getButtonTextColor({bool isLightTheme = true}) => isLightTheme ? lightButtonText : darkButtonText;

  static List<Color> colors = [
    Color(0xFFFDFBFB),
    Color(0xFFEBEDEE),
  ];
  static List<Color> priceCard = [
    MyColor.white,
    Color(0xFFE3E3E3),
  ];
  static List<Color> vipCard = [
    Color(0xFFFFDE98),
    const Color(0xFFFFBD31),
  ];
}
