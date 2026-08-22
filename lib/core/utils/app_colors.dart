import 'package:flutter/material.dart';

/// ParkSmart app color system.
///
/// Semantic, purpose-driven palette pulled from the parking app UI: deep
/// midnight navy for headers/hero surfaces and the desktop sidebar, electric
/// blue as the primary action/brand color (CTAs, active nav, links, live
/// map markers), and a soft cool-gray canvas instead of stark white, which
/// reads calmer behind data-dense cards and maps.
///
/// Every color maps to a real, recurring use case - nothing was added "just
/// in case." Apply colors at the call site (e.g. `AppTextStyle.title.copyWith(
/// color: AppColors.textPrimary)`), never bake them into a text style.
class AppColors {
  AppColors._();

  // ---- Brand ----
  /// CTAs, primary buttons, active nav icon/label, links, selected map pins
  static const Color primary = Color(0xFF2563EB);
  /// Pressed states, gradient end for primary buttons/banners
  static const Color primaryDark = Color(0xFF1D4ED8);
  /// Secondary blue accents - live indicators, mono stat numbers, icons
  static const Color primaryLight = Color(0xFF60A5FA);
  /// Badges, subtle highlight fills, selected chip/pill background
  static const Color primaryPale = Color(0xFFEFF6FF);
  /// Premium contrast - hero headers, sidebar, dark gradient surfaces
  static const Color secondary = Color(0xFF0D1117);
  /// Gradient partner for [secondary] on hero/header backgrounds
  static const Color secondaryDark = Color(0xFF1A2744);
  /// "Reservations" section accent - used sparingly for a secondary category
  static const Color accent = Color(0xFF7C3AED);

  // ---- Surfaces ----
  /// Screen background
  static const Color background = Color(0xFFF1F4F9);
  /// Sheets, dialogs, modals, input fields
  static const Color surface = Color(0xFFFFFFFF);
  /// Parking lot / reservation / history cards (kept separate from
  /// [surface] so the two can diverge later without renaming call sites)
  static const Color card = Color(0xFFFFFFFF);
  /// Muted fill for stat tiles, info rows, inactive filter chips
  static const Color surfaceMuted = Color(0xFFF8FAFC);

  // ---- Text ----
  /// Parking lot names, headings, primary values
  static const Color textPrimary = Color(0xFF0F172A);
  /// Section labels, secondary headings
  static const Color textSecondary = Color(0xFF334155);
  /// Descriptions, addresses, body copy
  static const Color textBody = Color(0xFF64748B);
  /// Timestamps, captions, disabled/placeholder text
  static const Color textTertiary = Color(0xFF94A3B8);
  /// Text on dark surfaces (headers, sidebar) at full opacity
  static const Color textOnDark = Color(0xFFFFFFFF);
  /// Muted text on dark surfaces - subtitles, sub-labels in hero headers
  static const Color textOnDarkMuted = Color(0xB3FFFFFF); // white @ 70%

  // ---- Lines ----
  /// Input borders, card borders
  static const Color border = Color(0xFFE2E8F0);
  /// List separators, subtle dividers within cards
  static const Color divider = Color(0xFFF1F5F9);
  /// Borders/dividers on dark surfaces (sidebar, hero headers)
  static const Color borderOnDark = Color(0x1AFFFFFF); // white @ 10%

  // ---- Status ----
  /// Available spaces, confirmed sessions, "LIVE" indicators
  static const Color success = Color(0xFF16A34A);
  /// Darker green for gradients/pressed states on success surfaces
  static const Color successDark = Color(0xFF15803D);
  /// Light success fill - banners, pills, confirmation backgrounds
  static const Color successPale = Color(0xFFF0FDF4);
  /// Errors, cancel actions, session-expiring alerts, "almost full" status
  static const Color error = Color(0xFFDC2626);
  /// Bright error variant - notification dots, badges
  static const Color errorBright = Color(0xFFEF4444);
  /// Light error fill - cancel buttons, warning banners
  static const Color errorPale = Color(0xFFFFF1F2);
  /// "Filling up" status, expiring-soon accents, pricing highlights
  static const Color warning = Color(0xFFD97706);
  /// Light warning fill - reminder notification backgrounds
  static const Color warningPale = Color(0xFFFEF3C7);
  /// Star ratings only
  static const Color rating = Color(0xFFD97706);

  // ---- Utility ----
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color transparentColor = Color(0x00FFFFFF);
  /// Modal/sheet scrim
  static const Color scrim = Color(0x8C000000); // black @ 55%
}
