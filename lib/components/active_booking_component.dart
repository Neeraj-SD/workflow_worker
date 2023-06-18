import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_worker/custom_widget/space.dart';
import 'package:workflow_worker/job/controller/job_controller.dart';
import 'package:workflow_worker/job/model/job.dart';
import 'package:workflow_worker/main.dart';
import 'package:workflow_worker/models/active_bookings_model.dart';
import 'package:workflow_worker/screens/cancel_booking_screen.dart';
import 'package:workflow_worker/utils/colors.dart';
import 'package:workflow_worker/utils/images.dart';

class ActiveBookingComponent extends StatelessWidget {
  final JobModel? jobModel;
  final int index;

  ActiveBookingComponent(this.index, {this.jobModel});

  final JobController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.goToJobDetailPage(index);

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => CancelBookingScreen(activeId: index)),
        // );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          color: appData.isDark ? cardColorDark : cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${jobModel?.tags?[0].name}',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ],
                ),
                Space(4),
                Divider(color: dividerColor, thickness: 1),
                Space(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        child: Image.network(jobModel?.image ?? NOIMAGE,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Space(8),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${jobModel?.location}',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18)),
                        Space(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.watch_later_outlined,
                                color: orangeColor, size: 16),
                            Space(2),
                            Text(
                                DateFormat("EEE, MMM d")
                                    .format(jobModel?.date ?? DateTime.now()),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Space(80),
                            Text("Number of bids",
                                style: TextStyle(
                                    color: orangeColor, fontSize: 12)),
                            Space(2),
                            Text('${jobModel?.bids?.length ?? 0}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                        // Text('data')
                      ],
                    )
                  ],
                ),
                Space(4),
                Space(15),
                Divider(color: dividerColor, thickness: 1),
                Space(4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
