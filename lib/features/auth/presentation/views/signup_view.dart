import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/features/auth/data/repos/register_repo/register_repo_imple.dart';
import 'package:parking/features/auth/presentation/manager/cubits/register_with_email/register_with_email_cubit.dart';
import 'package:parking/features/auth/presentation/manager/cubits/register_with_facebook/register_with_facebook_cubit.dart';
import 'package:parking/features/auth/presentation/manager/cubits/register_with_google/register_with_google_cubit.dart';
import 'package:parking/features/auth/presentation/views/widgets/signup_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RegisterWithEmailCubit(registerRepo: RegisterRepoImple()),
        ),
        BlocProvider(
          create: (context) =>
              RegisterWithFacebookCubit(registerRepo: RegisterRepoImple()),
        ),
        BlocProvider(
          create: (context) =>
              RegisterWithGoogleCubit(registerRepo: RegisterRepoImple()),
        ),
      ],
      child: const Scaffold(
        backgroundColor: AppColors.background,
        body: SignupViewBody(),
      ),
    );
  }
}
