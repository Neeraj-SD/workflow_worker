import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workflow_worker/core/api_provider.dart';
import '../model/user.dart';

class ProfileController extends GetxController {
  final _storage = GetStorage();
  final ApiProvider api = Get.find();

  late UserModel user;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController locationController;

  @override
  void onInit() async {
    super.onInit();
    user = UserModel.fromJson(_storage.read('user'));
    nameController = TextEditingController(text: user.name);
    phoneController = TextEditingController(text: user.phoneNumber);
    locationController = TextEditingController(text: user.address);
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    phoneController.dispose();
    locationController.dispose();
  }

  void onProfileUpdate() async {
    if (nameController.text.isEmpty) {
      Get.snackbar('Name is required', 'Please fill in your name');
      return;
    }
    if (phoneController.text.isEmpty) {
      Get.snackbar(
          'Phone number is required', 'Please fill in your phone number');
      return;
    }
    if (locationController.text.isEmpty) {
      Get.snackbar('Address is required', 'Please fill in your address');
      return;
    }

    user = user.copyWith(
      name: nameController.text,
      phoneNumber: phoneController.text,
      address: locationController.text,
      isComplete: true,
    );

    final result = await api.patchApi('/api/user/me/', user.toJson());
    await _storage.write('isComplete', true);
    await _storage.write('user', user.toJson());
    Get.offAllNamed('/');
  }
}
