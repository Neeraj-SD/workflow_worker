import 'package:get/get.dart';
import 'package:workflow_worker/auth/controller/auth_controller.dart';
import 'package:workflow_worker/core/api_provider.dart';
import 'package:workflow_worker/job/controller/job_add_controller.dart';
import 'package:workflow_worker/job/controller/job_controller.dart';
import 'package:workflow_worker/profile/controller/profile_controller.dart';

class GetXDependencyInjector {
  void onInit() {
    Get.put(ApiProvider());
    Get.put(AuthController());

    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => JobAddController(), fenix: true);
    Get.lazyPut(() => JobController(), fenix: true);
  }
}
