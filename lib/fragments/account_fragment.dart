import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_worker/auth/controller/auth_controller.dart';
import 'package:workflow_worker/fragments/bookings_fragment.dart';
import 'package:workflow_worker/models/customer_details_model.dart';
import 'package:workflow_worker/profile/controller/profile_controller.dart';
import 'package:workflow_worker/screens/favourite_services_screen.dart';
import 'package:workflow_worker/screens/my_profile_screen.dart';
import 'package:workflow_worker/screens/notification_screen.dart';
import 'package:workflow_worker/utils/colors.dart';
import 'package:workflow_worker/utils/images.dart';

import '../custom_widget/space.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  final ProfileController profileController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Account",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 90,
                width: 90,
                child: CircleAvatar(
                    backgroundImage:
                        NetworkImage('${profileController.user.picture}'))),
            Space(8),
            Text('${profileController.user.name}',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
            Space(4),
            Text('${profileController.user.email}',
                textAlign: TextAlign.start,
                style: TextStyle(color: secondaryColor, fontSize: 12)),
            Space(16),
            ListTile(
              horizontalTitleGap: 4,
              leading: Icon(Icons.person, size: 20),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("My Profile"),
              trailing: Icon(Icons.edit, size: 16),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfileScreen()));
              },
            ),
            ListTile(
              horizontalTitleGap: 4,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(Icons.calendar_month, size: 20),
              title: Text("My bookings"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookingsFragment(fromProfile: true)));
              },
            ),
            Space(16),
            ListTile(
              horizontalTitleGap: 4,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(Icons.logout_rounded, size: 20),
              title: Text("Logout"),
              onTap: () => authController.signOut(),
            ),
            Space(16),
          ],
        ),
      ),
    );
  }
}
