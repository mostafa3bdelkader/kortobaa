import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kortobaa/presentation/screens/main_screen.dart';
import 'package:kortobaa/providers/auth_provider.dart';
import 'package:kortobaa/providers/post_provider.dart';
import 'package:provider/provider.dart';

import 'helpers/theme_data.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => AuthProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => PostsProvider(),
            ),
          ],
          child: MaterialApp(
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
            theme: themeData,
            home: child,
          ),
        );
      },
      child: MainScreen(),
    );
  }
}
