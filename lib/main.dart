import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/cache/cache_helper.dart';
import 'package:parking/core/utils/app_router.dart';
import 'package:parking/core/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await CacheHelper.initInstace();
  runApp(const ParkingApp());
}

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 1000),
      child: MaterialApp.router(
        title: 'parking',
        theme: AppTheme.light,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
