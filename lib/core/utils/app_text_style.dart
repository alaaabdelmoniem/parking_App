import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_theme.dart';

/// ParkSmart app text styles.
///
/// Sizes/weights are pulled directly from the recurring inline styles in the
/// UI (hero titles at 22-24/800, card titles at 13-15/700, captions at
/// 10-11/500-600, mono numerals for prices/timers/codes at 16-36).
///
/// Styles carry NO color — apply color at the call site depending on
/// surface (light card vs. dark hero header), e.g.
/// `AppTextStyle.cardTitle.copyWith(color: AppColors.textPrimary)`.
/// The two exceptions are [heroTitle]/[heroSubtitle], which are only ever
/// used on dark surfaces, so baking in [AppColors.textOnDark] avoids
/// repeating it at every call site.
class AppTextStyle {
  AppTextStyle._();

  static const String _sans = AppTheme.fontFamily;
  static const String _mono = AppTheme.monoFontFamily;

  // ---- Hero / header (dark gradient surfaces: Home, History, Profile) ----
  /// "Alex Chen", "Parking History" — dark hero header titles
  static TextStyle heroTitle = TextStyle(
    fontFamily: _sans,
    fontSize: 22.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.3,
    color: AppColors.textOnDark,
    height: 1.15,
  );

  /// "Good afternoon", "47 sessions this month" — hero subtitle/eyebrow
  static TextStyle heroSubtitle = TextStyle(
    fontFamily: _sans,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnDarkMuted,
  );

  // ---- Page / section titles (light surfaces) ----
  /// Screen-level titles — "My Reservations", "Get Directions"
  static TextStyle pageTitle = TextStyle(
    fontFamily: _sans,
    fontSize: 22.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.3,
  );

  /// Sheet/modal headers — "Active Session", "Notifications"
  static TextStyle sheetTitle = TextStyle(
    fontFamily: _sans,
    fontSize: 17.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.2,
  );

  /// Section labels above a group — "Nearby Parking", "Amenities"
  static TextStyle sectionTitle = TextStyle(
    fontFamily: _sans,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  /// Uppercase eyebrow labels — "PAYMENT METHODS", "ACCOUNT & SETTINGS"
  static TextStyle sectionLabel = TextStyle(
    fontFamily: _sans,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
  );

  // ---- Cards ----
  /// Parking lot / reservation card titles
  static TextStyle cardTitle = TextStyle(
    fontFamily: _sans,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  /// Card subtitle — address, distance, "0.7 mi · Garage"
  static TextStyle cardSubtitle = TextStyle(
    fontFamily: _sans,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textBody,
  );

  /// Body copy — reviews, descriptions, entrance hints
  static TextStyle body = TextStyle(
    fontFamily: _sans,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textBody,
  );

  /// Small body copy — helper text, form hints
  static TextStyle bodySmall = TextStyle(
    fontFamily: _sans,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textBody,
  );

  // ---- Buttons / pills ----
  /// Primary button label — "Reserve Spot", "Extend Parking"
  static TextStyle buttonLarge = TextStyle(
    fontFamily: _sans,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  /// Secondary button / pill label — "Cancel", "Modify", tab labels
  static TextStyle buttonSmall = TextStyle(
    fontFamily: _sans,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  /// Status pill text — "Active Now", "Filling up"
  static TextStyle pill = TextStyle(
    fontFamily: _sans,
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
  );

  // ---- Captions / meta ----
  /// Timestamps, review dates, receipt IDs (non-numeric meta)
  static TextStyle caption = TextStyle(
    fontFamily: _sans,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
  );

  /// Smallest labels — stat sub-labels, grid item captions
  static TextStyle captionSmall = TextStyle(
    fontFamily: _sans,
    fontSize: 9.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textTertiary,
    letterSpacing: 0.4,
  );

  // ---- Monospace (prices, timers, spot/booking codes) ----
  /// Large mono display — live cost, countdown timer ("$12.00", "01:27:04")
  static TextStyle monoDisplay = TextStyle(
    fontFamily: _mono,
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
  );

  /// Prominent price — card price tags, reservation totals
  static TextStyle monoPriceLarge = TextStyle(
    fontFamily: _mono,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  /// Inline price — "$6/hr" within a row
  static TextStyle monoPrice = TextStyle(
    fontFamily: _mono,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  /// Small mono — spot numbers, booking codes, receipt IDs
  static TextStyle monoSmall = TextStyle(
    fontFamily: _mono,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );
}
