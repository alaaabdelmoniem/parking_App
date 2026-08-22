import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ParkSmart app theme.
///
/// Rounded, card-heavy UI with a dark navy hero/sidebar and a soft cool-gray
/// canvas. Buttons and pills use large radii (12-16) to match the app's
/// `rounded-2xl` / `rounded-full` conventions. Swap [fontFamily] /
/// [monoFontFamily] for the bundled Plus Jakarta Sans + Geist Mono fonts
/// once added to pubspec.yaml.
class AppTheme {
  AppTheme._();

  static const String fontFamily = 'PlusJakartaSans';
  static const String monoFontFamily = 'GeistMono';

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    final colorScheme = base.colorScheme.copyWith(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.textOnDark,
      primaryContainer: AppColors.primaryPale,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textOnDark,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.textOnDark,
      outline: AppColors.border,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
    
      splashFactory: InkRipple.splashFactory,

      // ---- App bar (mirrors the dark gradient hero headers) ----
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textOnDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: AppColors.textOnDark,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: AppColors.textOnDark),
      ),

      // ---- Cards (parking lot / reservation / history cards) ----
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),

      // ---- Buttons ----
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnDark,
          disabledBackgroundColor: AppColors.textTertiary,
          minimumSize: const Size.fromHeight(52),
          elevation: 0,
          shadowColor: AppColors.primary.withValues(alpha: 0.35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          side: const BorderSide(color: AppColors.border, width: 1.5),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ---- Inputs (search bars, price range labels) ----
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceMuted,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      // ---- Chips (feature filters, status pills) ----
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.divider,
        selectedColor: AppColors.secondary,
        labelStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textOnDark,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // ---- Bottom navigation (mirrors the dark BottomNav bar) ----
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.secondary,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: Color(0x61FFFFFF), // white @ 38%
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
      ),

      // ---- Dividers ----
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ---- Progress indicators (availability bars, session countdown) ----
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.border,
        circularTrackColor: AppColors.border,
      ),

      // ---- Switches (profile toggles) ----
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(AppColors.whiteColor),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primary
              : AppColors.textTertiary.withValues(alpha: 0.5),
        ),
      ),

      // ---- Bottom sheets (ParkingDetail, ReservationFlow, etc.) ----
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        modalBackgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      // ---- Text ----
      textTheme: base.textTheme
          .apply(
            fontFamily: fontFamily,
            bodyColor: AppColors.textPrimary,
            displayColor: AppColors.textPrimary,
          )
          .copyWith(
            headlineSmall: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
            titleMedium: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            bodyMedium: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textBody,
            ),
            labelSmall: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textTertiary,
              letterSpacing: 0.4,
            ),
          ),

      // ---- Icons ----
      iconTheme: const IconThemeData(color: AppColors.textSecondary),
    );
  }

  /// Text style helper for monospace values - prices, timers, spot numbers,
  /// booking codes. Apply on top of an existing style, e.g.
  /// `Theme.of(context).textTheme.titleMedium!.merge(AppTheme.mono)`.
  static const TextStyle mono = TextStyle(fontFamily: monoFontFamily);
}
