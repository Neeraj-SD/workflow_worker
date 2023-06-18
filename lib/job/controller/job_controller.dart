import 'package:get/get.dart';
import 'package:workflow_worker/core/api_provider.dart';
import 'package:workflow_worker/job/model/job.dart';
import 'package:workflow_worker/screens/cancel_booking_screen.dart';
import 'package:workflow_worker/screens/last_booking_screen.dart';

class JobController extends GetxController {
  final ApiProvider api = Get.find();

  final activeJobs = <JobModel>[].obs;
  final pastJobs = <JobModel>[].obs;
  var activeLoading = false.obs;
  var pastJobLoading = false.obs;
  var selectedJobIndex;
  var selectedBidIndex = (-1).obs;
  late JobModel selectedJob;

  @override
  void onInit() {
    super.onInit();
    fetchActiveJobs();
    fetchPastJobs();
  }

  void fetchActiveJobs() async {
    activeLoading(true);
    final result =
        await api.getApi('/api/job/jobs/?is_open=true&is_worker=true');
    activeJobs.value = jobModelFromJson(result.body);
    activeLoading(false);
  }

  void fetchPastJobs() async {
    pastJobLoading(true);
    final result = await api.getApi('/api/job/jobs/?is_open=false');
    pastJobs.value = jobModelFromJson(result.body);
    pastJobLoading(false);
  }

  void goToJobDetailPage(int index) {
    selectedJobIndex = index;
    selectedJob = activeJobs[index];
    selectedBidIndex.value = -1;
    Get.to(CancelBookingScreen());
  }

  Future pullToRefresh() async {
    fetchActiveJobs();
    fetchPastJobs();
    return Future.delayed(Duration(seconds: 1));
  }

  void setSelectedBid(int index) {
    selectedBidIndex.value = index;
  }

  void acceptBid() async {
    if (selectedBidIndex == -1) {
      Get.snackbar(
        'No bid selected',
        'Please select a bid.',
      );
      return;
    }
    int bidId = selectedJob.bids?[selectedBidIndex.value].id ?? 0;
    final result = await api.postApi('/api/job/bids/$bidId/accept-bid/', {});
    pullToRefresh();
    Get.off(() => LastBookingScreen(cancel: false));
  }
}
