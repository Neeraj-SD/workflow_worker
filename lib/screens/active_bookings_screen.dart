import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_worker/components/active_booking_component.dart';
import 'package:workflow_worker/job/controller/job_controller.dart';

import '../models/active_bookings_model.dart';

class ActiveBookingsScreen extends StatefulWidget {
  const ActiveBookingsScreen({Key? key}) : super(key: key);

  @override
  State<ActiveBookingsScreen> createState() => _ActiveBookingsScreenState();
}

class _ActiveBookingsScreenState extends State<ActiveBookingsScreen> {
  final JobController jobController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () => jobController.pullToRefresh(),
        child: Scaffold(
          body: jobController.activeLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : jobController.activeJobs.isEmpty
                  ? Center(child: Text("No  Data"))
                  : ListView.builder(
                      padding: EdgeInsets.only(
                          left: 8, top: 8, right: 8, bottom: 16),
                      itemCount: jobController.activeJobs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ActiveBookingComponent(
                            jobModel: jobController.activeJobs[index], index);
                      },
                    ),
        ),
      ),
    );
  }
}
