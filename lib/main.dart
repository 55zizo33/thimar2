import 'package:app/core/app_theme.dart';
import 'package:app/logic/firebase_helper.dart';
import 'package:app/views/auth/login.dart';
import 'package:app/views/test_firebase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/service_locator.dart';
import 'logic/bloc_ovserver.dart';
import 'logic/cache_helper.dart';
import 'logic/helper_methods.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  initServiceLocator();
  Bloc.observer=AppBlocObserver();
  await FirebaseHelper().init();

  runApp(
      EasyLocalization(
    supportedLocales: const [Locale("en"), Locale("ar"),],
    path: "assets/translations",
    fallbackLocale: const Locale("en"),
    startLocale: const Locale("ar"),
    child: const MyApp(),
  ));
}
class MyApp extends StatefulWidget {

  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),

      child: const TestFirebaseView(),

      builder: (context, child) => MaterialApp(
        title: 'Thimar2',
        theme: AppTheme.light,
        navigatorKey: navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: child,
      ),
    );
  }
}