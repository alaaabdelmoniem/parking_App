import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:parking/core/routers/app_router.dart';
import 'package:parking/core/theme/app_colors.dart';
import 'package:parking/core/theme/app_text_style.dart';
import 'package:parking/core/utils/functions/show_snackbar_message.dart';
import 'package:parking/core/utils/widgets/custom_outlined_button.dart';
import 'package:parking/features/auth/presentation/manager/cubits/logout/logout_cubit.dart';
import 'package:parking/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:parking/features/profile/presentation/views/widgets/profile_section_title.dart';
import 'package:parking/features/profile/presentation/views/widgets/setting_group.dart';
import 'package:parking/features/profile/presentation/views/widgets/settings_tile.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  bool _notificationsOn = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: AppTextStyle.pageTitle.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 20.h),
            const ProfileHeader(),
            SizedBox(height: 20.h),

            const ProfileSectionTitle('Account'),
            SettingsGroup(
              children: [
                SettingsTile(
                  icon: Icons.person_outline,
                  title: 'Personal information',
                  onTap: () {}, // TODO
                ),
                SettingsTile(
                  icon: Icons.credit_card_outlined,
                  title: 'Payment methods',
                  onTap: () {}, // TODO: showAddCardSheet(...)
                ),
                SettingsTile(
                  icon: Icons.directions_car_outlined,
                  title: 'My vehicles',
                  onTap: () {}, // TODO
                ),
              ],
            ),
            SizedBox(height: 20.h),

            const ProfileSectionTitle('Preferences'),
            SettingsGroup(
              children: [
                SettingsTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  trailing: Switch(
                    value: _notificationsOn,
                    onChanged: (v) => setState(() => _notificationsOn = v),
                    activeTrackColor: AppColors.primary,
                    thumbColor: const WidgetStatePropertyAll(Colors.white),
                  ),
                ),
                SettingsTile(
                  icon: Icons.language,
                  title: 'Language',
                  value: 'English',
                  onTap: () {}, // TODO
                ),
              ],
            ),
            SizedBox(height: 20.h),

            const ProfileSectionTitle('Support'),
            SettingsGroup(
              children: [
                SettingsTile(
                  icon: Icons.help_outline,
                  title: 'Help center',
                  onTap: () {}, // TODO
                ),
                SettingsTile(
                  icon: Icons.shield_outlined,
                  title: 'Terms & privacy',
                  onTap: () {}, // TODO
                ),
              ],
            ),
            SizedBox(height: 24.h),

            BlocConsumer<LogoutCubit, LogoutState>(
              listener: (context, state) {
                if (state is LogoutFailure) {
                  showSnackbarMessage(
                    context,
                    content: Text(state.errorMessage),
                    color: AppColors.error,
                  );
                } else if (state is LogoutSuccess) {
                  GoRouter.of(context).pushReplacement(AppRouter.kLoginView); 
                }
              },
              builder: (context, state) {
                bool isLoading = (state is LogoutLoading);
                return CustomOutlinedButton(
                  icon: Icons.logout_rounded,
                  label: isLoading ? 'loading...' : 'Log out',
                  onPressed: () {
                    context.read<LogoutCubit>().logout();
                  },
                  borderColor: AppColors.error,
                  radius: 15.r,
                );
              },
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
