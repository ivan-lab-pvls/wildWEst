import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:neptune/theme/default.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/audio.dart';
import 'router/router.dart';

final locator = GetIt.instance;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // locator<SharedPreferences>().clear();
  if (locator<SharedPreferences>().getBool('diff1') == null) {
    await locator<SharedPreferences>().setBool('diff1', true);
    await locator<SharedPreferences>().setBool('diff2', false);
    await locator<SharedPreferences>().setBool('diff3', false);
  }
  runApp(
    MainApp(),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: MaterialApp.router(
              theme: theme,
              debugShowCheckedModeBanner: false,
              routerConfig: _appRouter.config(),
            ));
      },
    );
  }
}
