import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/features/auth/data/repos/logout_repo/logout_repo_imple.dart';
import 'package:parking/features/auth/presentation/manager/cubits/logout/logout_cubit.dart';
import 'package:parking/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LogoutCubit(logoutRepo: LogoutRepoImple()),
        child: const ProfileViewBody(),
      ),
    );
  }
}
