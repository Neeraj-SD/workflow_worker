import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workflow_worker/custom_widget/space.dart';
import 'package:workflow_worker/job/model/job.dart';
import 'package:workflow_worker/main.dart';
import 'package:workflow_worker/models/last_bookings_model.dart';
import 'package:workflow_worker/utils/colors.dart';
import 'package:workflow_worker/utils/images.dart';
import 'package:workflow_worker/utils/widgets.dart';

class BookingHistoryComponent extends StatelessWidget {
  final JobModel? jobModel;
  final int index;

  BookingHistoryComponent(this.index, {this.jobModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAlertDialog(context, index: index);
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
                      '${jobModel?.location}',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    Text(
                      jobModel?.status == 'A' ? 'Accepted' : 'Cancelled',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: jobModel?.status == "A" ? greenColor : redColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Space(15),
                Divider(color: dividerColor, thickness: 1),
                Space(2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.height * 0.07,
                        child: Image.asset(home, fit: BoxFit.cover),
                      ),
                    ),
                    Space(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${jobModel?.tags?[0].name}',
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
                            Space(2),
                            Text("at",
                                style: TextStyle(
                                    color: orangeColor, fontSize: 12)),
                            Space(2),
                            Text(
                                DateFormat("h:mm a")
                                    .format(jobModel?.date ?? DateTime.now()),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Space(4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "₹${jobModel?.acceptedBid?.amount}",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
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
