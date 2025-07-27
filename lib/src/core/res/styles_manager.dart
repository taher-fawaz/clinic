import 'package:flutter/material.dart';

import 'font_manager.dart';

abstract class TextStyleManager {
  static TextStyle _getTextStyle(double fontSize, FontWeight fontWeight,
      {Color? color, double? letterSpacing, double? height, String? fontFamily}) {
    return TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        height: height,
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight);
  }

  // Locale-aware text style methods
  static TextStyle _getLocalizedTextStyle(double fontSize, FontWeight fontWeight,
      {Color? color, double? letterSpacing, double? height, Locale? locale}) {
    return _getTextStyle(
      fontSize,
      fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: FontFamilyManager.getFontWithFallback(locale),
    );
  }

// Regular style methods (with optional locale support)

  static TextStyle getRegularStyle(
      {double fontSize = FontSize.s14, Color color = Colors.black, Locale? locale}) {
    return locale != null 
        ? _getLocalizedTextStyle(fontSize, FontWeightManager.regular, color: color, locale: locale)
        : _getTextStyle(fontSize, FontWeightManager.regular, color: color, fontFamily: FontFamilyManager.englishFont);
  }

  static TextStyle getLightStyle(
      {double fontSize = FontSize.s12, Color color = Colors.black, Locale? locale}) {
    return locale != null 
        ? _getLocalizedTextStyle(fontSize, FontWeightManager.light, color: color, locale: locale)
        : _getTextStyle(fontSize, FontWeightManager.light, color: color, fontFamily: FontFamilyManager.englishFont);
  }

  static TextStyle getBoldStyle(
      {double fontSize = FontSize.s18,
      Color color = Colors.black,
      double? letterSpacing = 1.5,
      double? height = 1.5,
      Locale? locale}) {
    return locale != null 
        ? _getLocalizedTextStyle(fontSize, FontWeightManager.bold,
            color: color, letterSpacing: letterSpacing, height: height, locale: locale)
        : _getTextStyle(fontSize, FontWeightManager.bold,
            color: color, letterSpacing: letterSpacing, height: height, fontFamily: FontFamilyManager.englishFont);
  }

  static TextStyle getBlackStyle(
      {double fontSize = FontSize.s36, Color color = Colors.black, Locale? locale}) {
    return locale != null 
        ? _getLocalizedTextStyle(fontSize, FontWeightManager.black, color: color, locale: locale)
        : _getTextStyle(fontSize, FontWeightManager.black, color: color, fontFamily: FontFamilyManager.englishFont);
  }

  static TextStyle getSemiBoldStyle(
      {double fontSize = FontSize.s16, Color color = Colors.black, Locale? locale}) {
    return locale != null 
        ? _getLocalizedTextStyle(fontSize, FontWeightManager.semiBold, color: color, locale: locale)
        : _getTextStyle(fontSize, FontWeightManager.semiBold, color: color, fontFamily: FontFamilyManager.englishFont);
  }

  static TextStyle getMediumStyle(
      {double fontSize = FontSize.s16, Color color = Colors.black, Locale? locale}) {
    return locale != null 
        ? _getLocalizedTextStyle(fontSize, FontWeightManager.medium, color: color, locale: locale)
        : _getTextStyle(fontSize, FontWeightManager.medium, color: color, fontFamily: FontFamilyManager.englishFont);
  }

  // Convenience methods for specific locales
  static TextStyle getArabicStyle(
      {double fontSize = FontSize.s14, Color color = Colors.black, FontWeight fontWeight = FontWeightManager.regular}) {
    return _getTextStyle(fontSize, fontWeight, color: color, fontFamily: FontFamilyManager.arabicFont);
  }

  static TextStyle getEnglishStyle(
      {double fontSize = FontSize.s14, Color color = Colors.black, FontWeight fontWeight = FontWeightManager.regular}) {
    return _getTextStyle(fontSize, fontWeight, color: color, fontFamily: FontFamilyManager.englishFont);
  }
}
