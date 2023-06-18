import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workflow_worker/core/api_provider.dart';
import '../model/user.dart';

class AuthController extends GetxController {
  late GoogleSignIn _googleSignIn;
  final GetStorage _storage = GetStorage();
  final ApiProvider api = Get.find();
  // final ApiProviderNoAuth apiNoAuth = Get.find();
  var isSignIn = false.obs;
  var text1 = "Continue with Google".obs;
  var text2 = "Continue with Apple".obs;
  var isReview = true.obs;

  @override
  void onInit() async {
    super.onInit();
    _googleSignIn = GoogleSignIn();
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.none) {
    //     Get.snackbar(
    //         "Network Error", "Please check your internet connectivity");
    //   }
    // });
  }

  void signOut() async {
    await _googleSignIn.signOut();
    await _storage.erase();
    Get.offAllNamed('/login');
  }

  Future<void> googleSignIn() async {
    try {
      text1.value = "Logging you in...";
      isSignIn(true);
      final result = await _googleSignIn.signIn();
      final auth = await result!.authentication;

      Map data = {'access_token': auth.accessToken};
      log(data.toString());
      final response = await api.postApi('/auth/google/', data);
      log(response.body.toString());
      final apiToken = response.body['key'];

      await _storage.write('authToken', apiToken);

      final Response userResponse = await api.getApi('/api/user/me/');

      final UserModel userModel = userModelFromJson(userResponse.body);
      _storage.write('user', userModel.toJson());

      if (userModel.isComplete ?? false) {
        _storage.write('isComplete', true);
      } else {
        _storage.write('isComplete', false);
      }
      text1.value = "Logged in";
      isSignIn(false);
      Get.offAllNamed('/');
    } catch (error) {
      debugPrint(error.toString());
      isSignIn(false);
      text1.value = "Try Again";
      await Future.delayed(const Duration(seconds: 2));
      text1.value = "Continue with Google";
    } finally {
      isSignIn(false);
      text1.value = "Continue with Google";
    }
  }
}
