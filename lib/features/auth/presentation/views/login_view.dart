import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/features/auth/data/repos/login_repo/login_repo_imple.dart';
import 'package:parking/features/auth/presentation/manager/cubits/login_with_email/login_with_email_cubit.dart';
import 'package:parking/features/auth/presentation/manager/cubits/login_with_facebook/login_facebook_cubit.dart';
import 'package:parking/features/auth/presentation/manager/cubits/login_with_google/login_google_cubit.dart';
import 'package:parking/features/auth/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LoginWithEmailCubit(loginRepo: LoginRepoImple()),
        ),
        BlocProvider(
          create: (context) =>
              LoginGoogleCubit(loginRepo:  LoginRepoImple()),
        ),
        BlocProvider(
          create: (context) =>
              LoginFacebookCubit(loginRepo: LoginRepoImple()),
        ),
      ],
      child: const Scaffold(
        backgroundColor: AppColors.background,
        body: LoginViewBody(),
      ),
    );
  }
}
