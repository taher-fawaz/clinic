import 'package:clinic/src/core/res/app_res.dart';
import 'package:clinic/src/core/res/font_manager.dart';
import 'package:clinic/src/core/res/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

  static ThemeData data(bool isDark, {Locale? locale}) {
    return _buildTheme(isDark, locale);
  }

  // Convenience methods for specific locales
  static ThemeData arabicTheme(bool isDark) {
    return _buildTheme(isDark, const Locale('ar'));
  }

  static ThemeData englishTheme(bool isDark) {
    return _buildTheme(isDark, const Locale('en'));
  }

  static ThemeData _buildTheme(bool isDark, Locale? locale) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: ColorManager.primary,
      scaffoldBackgroundColor:
          isDark ? ColorManager.greyDark : ColorManager.backgroundPrimary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.primary,
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: ColorManager.primary,
        primaryContainer: ColorManager.primaryLight,
        secondary: ColorManager.secondary,
        secondaryContainer: ColorManager.secondaryLight,
        surface: isDark ? ColorManager.greyDark : ColorManager.surface,
        surfaceVariant:
            isDark ? ColorManager.greyDark : ColorManager.surfaceVariant,
        background:
            isDark ? ColorManager.black : ColorManager.backgroundPrimary,
        onPrimary: ColorManager.textOnPrimary,
        onSecondary: ColorManager.textOnPrimary,
        onSurface: isDark ? ColorManager.white : ColorManager.textPrimary,
        onBackground: isDark ? ColorManager.white : ColorManager.textPrimary,
        outline: isDark ? ColorManager.greyLight : ColorManager.border,
        error: ColorManager.error,
        onError: ColorManager.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? ColorManager.greyDark : ColorManager.surface,
        foregroundColor: isDark ? ColorManager.white : ColorManager.textPrimary,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        shadowColor: ColorManager.shadowColor,
        titleTextStyle: TextStyleManager.getBoldStyle(
          fontSize: FontSize.s18,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        iconTheme: IconThemeData(
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          size: 24.sp,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.textOnPrimary,
        elevation: 4.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        extendedTextStyle: TextStyleManager.getMediumStyle(
          fontSize: FontSize.s14,
          color: ColorManager.textOnPrimary,
          locale: locale,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.textOnPrimary,
          elevation: 2.h,
          shadowColor: ColorManager.shadowColor,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          textStyle: TextStyleManager.getMediumStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textOnPrimary,
            locale: locale,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorManager.primary,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          textStyle: TextStyleManager.getMediumStyle(
            fontSize: FontSize.s14,
            color: ColorManager.primary,
            locale: locale,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorManager.primary,
          backgroundColor: Colors.transparent,
          side: BorderSide(color: ColorManager.primary, width: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          textStyle: TextStyleManager.getMediumStyle(
            fontSize: FontSize.s16,
            color: ColorManager.primary,
            locale: locale,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorManager.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorManager.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorManager.borderFocus, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorManager.borderError, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorManager.borderError, width: 2),
        ),
        filled: true,
        fillColor: isDark
            ? ColorManager.greyDark.withOpacity(0.3)
            : ColorManager.surfaceVariant,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        labelStyle: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s14,
          color: isDark ? ColorManager.greyLight : ColorManager.textSecondary,
          locale: locale,
        ),
        hintStyle: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s14,
          color: ColorManager.textTertiary,
          locale: locale,
        ),
        errorStyle: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s12,
          color: ColorManager.error,
          locale: locale,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: FontFamilyManager.getFontWithFallback(locale),
      textTheme: TextTheme(
        // Display styles - for large text
        displayLarge: TextStyleManager.getBoldStyle(
          fontSize: FontSize.s32,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        displayMedium: TextStyleManager.getBoldStyle(
          fontSize: FontSize.s28,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        displaySmall: TextStyleManager.getBoldStyle(
          fontSize: FontSize.s24,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        // Headline styles - for section headers
        headlineLarge: TextStyleManager.getBoldStyle(
          fontSize: FontSize.s24,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        headlineMedium: TextStyleManager.getBoldStyle(
          fontSize: FontSize.s20,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        headlineSmall: TextStyleManager.getBoldStyle(
          fontSize: FontSize.s18,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        // Title styles - for card titles, dialog titles
        titleLarge: TextStyleManager.getBoldStyle(
          fontSize: FontSize.s18,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        titleMedium: TextStyleManager.getMediumStyle(
          fontSize: FontSize.s16,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        titleSmall: TextStyleManager.getMediumStyle(
          fontSize: FontSize.s14,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        // Body styles - for main content
        bodyLarge: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s16,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        bodyMedium: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s14,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        bodySmall: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s12,
          color: isDark ? ColorManager.greyLight : ColorManager.textSecondary,
          locale: locale,
        ),
        // Label styles - for buttons, form labels
        labelLarge: TextStyleManager.getMediumStyle(
          fontSize: FontSize.s14,
          color: isDark ? ColorManager.white : ColorManager.textPrimary,
          locale: locale,
        ),
        labelMedium: TextStyleManager.getMediumStyle(
          fontSize: FontSize.s12,
          color: isDark ? ColorManager.greyLight : ColorManager.textSecondary,
          locale: locale,
        ),
        labelSmall: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s10,
          color: isDark ? ColorManager.greyLight : ColorManager.textTertiary,
          locale: locale,
        ),
      ),
    );
  }
}
