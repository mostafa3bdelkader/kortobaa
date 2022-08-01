import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kortobaa/constants.dart';
import 'package:kortobaa/presentation/screens/login_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('ar', 'AE'),
          ],
          locale: Locale('ar', 'AE'),
          debugShowCheckedModeBanner: false,
          title: 'Kortobaa',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            backgroundColor: kOffWhite,
            fontFamily: "Almarai",
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kNavyBlue,
              ),
              subtitle1: TextStyle(
                fontSize: 14,
                color: kDarKGrey,
              ),
              subtitle2: TextStyle(
                color: kNavy,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: child,
        );
      },
      child: const LoginScreen(),
    );
  }
}
