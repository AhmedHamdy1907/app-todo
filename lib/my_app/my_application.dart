import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/theme/my_theme.dart';

import '../core/Routes_manegar/routes_manger.dart';
import '../presentaion/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManger.router,
        initialRoute:RoutesManger.login ,
        theme: MyTheme.ligth,
        darkTheme: MyTheme.dark,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
