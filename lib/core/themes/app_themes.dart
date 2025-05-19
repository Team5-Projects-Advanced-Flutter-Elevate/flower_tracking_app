import 'package:flower_tracking_app/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppThemes {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    // scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      titleSpacing: 0,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 20,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.mainColor,
      onPrimary: AppColors.white,
      secondary: AppColors.white,
      onSecondary: AppColors.mainColor,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.white,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        Color color;
        if (states.contains(WidgetState.selected)) {
          color = AppColors.mainColor;
        } else {
          color = AppColors.white[80]!;
        }
        return IconThemeData(color: color);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.mainColor,
          );
        } else {
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.white[80],
          );
        }
      }),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: AppColors.black[30],
        disabledForegroundColor: AppColors.white,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.all(14),
        backgroundColor: AppColors.mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 4,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.red),
        borderRadius: BorderRadius.circular(4),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.red),
      ),

      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.white[70],
      ),
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return const TextStyle(color: Colors.red); // Red label in error state
        }
        return ThemeData.light().textTheme.titleSmall?.copyWith(
              color: AppColors.black.withValues(
                alpha: 0.7,
              ), // Default label color
            ) ??
            const TextStyle();
      }),
      //suffixIcon: suffixIcon,
      fillColor: AppColors.white,
      filled: true,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
      ),
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
    //     textStyle: TextStyle(
    //       fontSize: 16,
    //       color: AppColors.mainColor,
    //       fontWeight: FontWeight.w600,
    //       fontFamily: GoogleFonts.inter().fontFamily,
    //     ),
    //   ),
    // ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.black,
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        textStyle: TextStyle(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors
              .green; // Fallback to Colors.green if AppColors.green is null
        }
        return null; // Use default (colorScheme.surface)
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green;
        }
        return null; // Use default
      }),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.black;
        } else if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        }
        return AppColors.black;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        return AppColors.black; // Subtle outline
      }),
    ),
  );
}
