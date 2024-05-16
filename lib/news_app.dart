import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theme/colors.dart';

class NewsApp extends StatelessWidget {
  final AppRouter appRouter;
  const NewsApp({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
        theme: ThemeData(
          primaryColor: ColorsManager.mainGreen,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: Routes.homeScreen,
      ),
    );
  }
}
