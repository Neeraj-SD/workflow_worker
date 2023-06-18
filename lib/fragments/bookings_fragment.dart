import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_worker/auth/controller/auth_controller.dart';
import 'package:workflow_worker/custom_widget/add_job.dart';
import 'package:workflow_worker/screens/active_bookings_screen.dart';
import 'package:workflow_worker/screens/booking_history_screen.dart';
import 'package:workflow_worker/utils/colors.dart';

class BookingsFragment extends StatefulWidget {
  final bool fromProfile;

  const BookingsFragment({Key? key, required this.fromProfile})
      : super(key: key);

  @override
  State<BookingsFragment> createState() => _BookingsFragmentState();
}

class _BookingsFragmentState extends State<BookingsFragment>
    with SingleTickerProviderStateMixin {
  late TabController bookingTabController =
      TabController(length: 2, vsync: this, initialIndex: 0);

  final AuthController authController = Get.find();

  @override
  void dispose() {
    super.dispose();
    bookingTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () => Get.to(AddJobWidget()),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //       onPressed: () => authController.signOut(),
        //       icon: const Icon(Icons.logout))
        // ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        leading: Visibility(
          visible: widget.fromProfile ? true : false,
          child: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Job Listings",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        bottom: TabBar(
          controller: bookingTabController,
          labelStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          indicatorColor: blackColor,
          tabs: [
            Tab(text: "Open Request"),
            Tab(text: "History"),
          ],
        ),
      ),
      body: TabBarView(
        controller: bookingTabController,
        children: [
          ActiveBookingsScreen(),
          BookingHistoryScreen(),
        ],
      ),
    );
  }
}
