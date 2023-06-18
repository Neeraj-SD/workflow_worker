import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_worker/job/controller/job_controller.dart';
import 'package:workflow_worker/screens/last_booking_screen.dart';
import 'package:workflow_worker/utils/colors.dart';
import 'package:workflow_worker/utils/expandable_text.dart';

import '../custom_widget/space.dart';
import '../main.dart';
import '../models/active_bookings_model.dart';

class CancelBookingScreen extends StatelessWidget {
  CancelBookingScreen({Key? key}) : super(key: key);

  final JobController controller = Get.find();

  String? refundMethod;

  String? reasonForCancel;

  int itemCount = 1;

  Widget _showAlertDialog() {
    return AlertDialog(
      title: Text('Alert'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('Please select valid details'),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            // Navigator.of(context).pop();
            // Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedJob = controller.selectedJob;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: const Text(
          "Job Details",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      bottomSheet: BottomSheet(
        elevation: 10,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 45),
                shape: StadiumBorder(),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Accept Bid")),
              onPressed: () => controller.acceptBid(),
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => ),
              // );
            ),
          );
        },
        onClosing: () {},
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: appData.isDark ? cardColorDark : cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      child: Image.network(
                                          selectedJob.image ?? '',
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Space(16),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${selectedJob.tags?[0].name}',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16),
                                      ),
                                      Space(4),
                                      Text(
                                        '${selectedJob.location}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: greyColor, fontSize: 12),
                                      ),
                                      Space(4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.watch_later_outlined,
                                              color: greyColor, size: 14),
                                          Space(2),
                                          Text(
                                            DateFormat("h:mm a").format(
                                                selectedJob.date ??
                                                    DateTime.now()),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                          Space(2),
                                          Text("on",
                                              style: TextStyle(
                                                  color: greyColor,
                                                  fontSize: 8)),
                                          Space(2),
                                          Text(
                                              DateFormat("EEE, MMM d").format(
                                                  selectedJob.date ??
                                                      DateTime.now()),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10)),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              // Container(
                              //   padding: EdgeInsets.all(3),
                              //   decoration: BoxDecoration(
                              //     borderRadius: (BorderRadius.circular(5)),
                              //     border: Border.all(
                              //         width: 1,
                              //         color: itemCountContainerBorder),
                              //     color: itemCountContainer,
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       Icon(Icons.remove,
                              //           color: blackColor, size: 16),
                              //       Container(
                              //         margin:
                              //             EdgeInsets.symmetric(horizontal: 3),
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal: 8, vertical: 2),
                              //         decoration: BoxDecoration(
                              //             borderRadius:
                              //                 BorderRadius.circular(3),
                              //             color: whiteColor),
                              //         child: Text(itemCount.toString(),
                              //             style: TextStyle(
                              //                 color: blackColor, fontSize: 16)),
                              //       ),
                              //       Icon(Icons.add,
                              //           color: blackColor, size: 16),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          Space(42),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: appData.isDark ? cardColorDark : cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, size: 20),
                          Space(24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                                Space(4),
                                Text(
                                  "${selectedJob.location}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: appData.isDark
                                        ? cardTextDark
                                        : cardText,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Space(8),
                          Icon(Icons.edit, size: 20),
                        ],
                      ),
                    ),
                  ),
                  Space(32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Description",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 18),
                      ),
                    ],
                  ),
                  Space(15),
                  // ExpandableText('${selectedJob.description}', key: key),
                  Text(
                    '${selectedJob.description}',
                    textAlign: TextAlign.start,
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 6,
                    style: TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Space(8),
                  Space(8),
                  Divider(indent: 8, endIndent: 8, color: greyColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Current Bids",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20)),
                    ],
                  ),
                  Space(8),
                  selectedJob.bids?.length == 0
                      ? const Center(
                          child: Text('No bids.'),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: selectedJob.bids?.length ?? 0,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () => controller.setSelectedBid(index),
                                child: Obx(
                                  () => Card(
                                    color: controller.selectedBidIndex.value ==
                                            index
                                        ? cardColorDark
                                        : cardColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "${selectedJob.bids?[index].user?.picture}"),
                                          ),
                                          title: Text(
                                            "${selectedJob.bids?[index].user?.name}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: controller
                                                            .selectedBidIndex
                                                            .value ==
                                                        index
                                                    ? Colors.white
                                                    : greyColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: starIconColor,
                                                  size: 16),
                                              Text(
                                                '${selectedJob.bids?[index].user?.userRating}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          // subtitle: Text(
                                          //   "Rating: ${selectedJob.bids?[index].user?.userRating}/5",
                                          //   textAlign: TextAlign.start,
                                          //   style: TextStyle(
                                          //       color: controller
                                          //                   .selectedBidIndex
                                          //                   .value ==
                                          //               index
                                          //           ? Colors.white
                                          //           : greyColor,
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 14),
                                          // ),
                                          trailing: Text(
                                            "₹${selectedJob.bids?[index].amount}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: controller
                                                            .selectedBidIndex
                                                            .value ==
                                                        index
                                                    ? Colors.white
                                                    : null),
                                          ),
                                        )),
                                  ),
                                ),
                              )),

                  Space(8),
                ],
              ),
            ),
            Space(16),
            Space(80),
          ],
        ),
      ),
    );
  }
}
