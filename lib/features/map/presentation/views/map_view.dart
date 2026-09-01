import 'package:flutter/material.dart';
import 'package:parking/features/map/data/repos/supabase_repo/supabase_repo_imple.dart';
import 'package:parking/features/map/presentation/manager/cubits/fetch_spots/fetch_spots_cubit.dart';
import 'package:parking/features/map/presentation/views/widgets/map_screeen_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchSpotsCubit(supabaseRepo: SupabaseRepoImple())..fetchSpots(),
      child: const Scaffold(body: MapScreenBody()),
    );
  }
}
