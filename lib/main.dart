import 'package:company/UI/component/conts.dart';
import 'package:company/UI/pages/intro_screen.dart';
import 'package:company/UI/pages/layout_screen.dart';
import 'package:company/UI/pages/sendemail_screen.dart';
import 'package:company/UI/pages/showemployee.dart';
import 'package:company/UI/pages/splash_screen.dart';

import 'package:company/cubit/blocobserver.dart';
import 'package:company/cubit/companyapp_cubit.dart';
import 'package:company/sevices/dio_helper.dart';
import 'package:company/util/company_theme.dart';
import 'package:company/util/local_cred.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String iniRout;
  await SharedPreferences.getInstance().then((value) {
    userId = value.getInt("userId") ?? null;
    // value.setInt("userId", 2);
    iniRout = value.getString('initRoute') ?? "/splashcreen";
    // userId = value.getInt("userId");

    print(" initRout${iniRout}");

    print("userId ${userId}");
  });
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp(iniRout));
}

class MyApp extends StatelessWidget {
  final String iniRout;
  MyApp(this.iniRout);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return BlocProvider(
        create: (context) => CompanyappCubit(),
        // ..getUserProfle()
        // ..getAllEmployee(),
        child: MaterialApp(
          theme: MylightTheme(),
          themeMode: ThemeMode.light,
          routes: {
            "/splashcreen": (_) => SplashScreen(),
            "/profile": (_) => LayOutScreen(),
          },
          initialRoute: iniRout,
          // home: ShowEmployeeDetileScreen(),
        ));
  }
}
