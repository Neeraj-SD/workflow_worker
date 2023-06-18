import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:workflow_worker/auth/controller/auth_controller.dart';
import 'package:workflow_worker/custom_widget/space.dart';
import 'package:workflow_worker/main.dart';
import 'package:workflow_worker/screens/otp_verification_screen.dart';
import 'package:workflow_worker/screens/sign_up_screen.dart';
import 'package:workflow_worker/utils/colors.dart';
import 'package:workflow_worker/utils/constant.dart';
import 'package:workflow_worker/utils/images.dart';
import 'package:workflow_worker/utils/widgets.dart';

// import '../custom_widget/space.dart';
// import '../main.dart';
// import '../utils/colors.dart';
// import '../utils/images.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness:
              appData.isDark ? Brightness.light : Brightness.dark),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Space(60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Space(60),
                Text("Welcome back!",
                    style: TextStyle(
                        fontSize: mainTitleTextSize,
                        fontWeight: FontWeight.bold)),
                Space(8),
                Text("Please Login to your account",
                    style: TextStyle(fontSize: 14, color: subTitle)),
                Space(16),
                Image.asset(splash_logo,
                    width: 100, height: 100, fit: BoxFit.cover),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                // width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    textStyle: TextStyle(fontSize: 16),
                    shape: StadiumBorder(),
                    backgroundColor: appData.isDark
                        ? Colors.grey.withOpacity(0.2)
                        : Colors.black,
                  ),
                  onPressed: () => authController.googleSignIn(),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Space(40),
                        Image.asset(icGoogle,
                            scale: 18,
                            color: appData.isDark ? whiteColor : whiteColor),
                        Obx(
                          () => Text(authController.text1.value,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white)),
                        ),
                        Space(40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
