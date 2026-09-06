import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/cache/cache_helper.dart';
import 'package:parking/core/utils/app_router.dart';
import 'package:parking/core/utils/app_theme.dart';
import 'package:parking/features/map/data/repos/overpass_repo/overpass_spots_imple.dart';
import 'package:parking/features/map/data/repos/supabase_repo/supabase_repo_imple.dart';
import 'package:parking/features/map/presentation/manager/cubits/fetch_spots/fetch_spots_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await CacheHelper.initInstace();

  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABASE_ANON_KEY'],
  );
  await OverpassSpotsImple().fetchOverpassGetSpots();

  runApp(const ParkingApp());
}

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 1000),
      child: BlocProvider(
        create: (context) =>
            FetchSpotsCubit(supabaseRepo: SupabaseRepoImple())
              ..fetchSpots(lat: 51.5074, lng: -0.1278),
        child: MaterialApp.router(
          title: 'parking',
          theme: AppTheme.light,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
