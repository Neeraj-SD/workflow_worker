import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workflow_worker/auth/view/login_screen.dart';
import 'package:workflow_worker/components/my_scroll_behaviour.dart';
import 'package:workflow_worker/getx_di.dart';
import 'package:workflow_worker/screens/dashboard_screen.dart';
import 'package:workflow_worker/screens/my_profile_screen.dart';
import 'package:workflow_worker/screens/splash_screen.dart';
import 'package:workflow_worker/utils/colors.dart';
import 'package:workflow_worker/utils/constant.dart';
import 'package:workflow_worker/utils/themes.dart';

import 'store/appData.dart';

AppData appData = AppData();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  GetXDependencyInjector().onInit();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return GetMaterialApp(
          scrollBehavior: MyScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: appData.mode,
          // home: SplashScreen(),
          // home: LoginScreen(),
          initialRoute: '/',

          getPages: [
            GetPage(
                name: '/',
                page: () => storage.hasData('authToken')
                    ? storage.read('isComplete') ?? false
                        ? DashBoardScreen()
                        : MyProfileScreen()
                    : LoginScreen()),
            // GetPage(name: '/posts', page: () => PostsScreen()),
            GetPage(name: '/login', page: () => LoginScreen()),
          ],
        );
      },
    );
  }
}
