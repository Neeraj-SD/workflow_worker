// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'package:workflow_worker/job/controller/job_add_controller.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:workflow_worker/utils/colors.dart';
import 'package:workflow_worker/utils/images.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:social_media_app/constants.dart';

// import 'package:social_media_app/providers/api.dart';

// import 'package:fluttertoast/fluttertoast.dart';

class AddJobWidget extends StatelessWidget {
  // const AddPost({Key key}) : super(key: key);

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    final returnValue = selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
    jobController.isDateTimeSelected.value = true;
    jobController.selectedDateTime.value = returnValue;
    return returnValue;
  }

  final JobAddController jobController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 0,
          backgroundColor: transparent,
          // leading: Visibility(
          //   // visible: widget.fromProfile ? true : false,
          //   child: IconButton(
          //     icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          title: const Text(
            "Add Job",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        await showSearch(
                          context: context,
                          delegate: CustomCommunitySearchDelegate(),
                        );
                        // setState(() {});
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Color.fromRGBO(225, 37, 255, 1),
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          width: 1.3,
                          color: Color.fromRGBO(225, 37, 255, 1),
                        ),
                      ),
                      child: Obx(
                        () => Row(
                          children: [
                            Text(
                              jobController.selectedTagName.value.isEmpty
                                  ? 'Choose a Type'
                                  : '${jobController.selectedTag.name}',
                              style: TextStyle(),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                      // color: Colors.purpleAccent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        // setState(() {});
                        showDateTimePicker(context: context);
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Color.fromRGBO(225, 37, 255, 1),
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          width: 1.3,
                          color: Color.fromRGBO(225, 37, 255, 1),
                        ),
                      ),
                      child: Obx(
                        () => Row(
                          children: [
                            Text(
                              !jobController.isDateTimeSelected.value
                                  ? 'Choose a Date'
                                  : '${DateFormat.yMd().add_jm().format(jobController.selectedDateTime.value)}',
                              style: TextStyle(),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                      // color: Colors.purpleAccent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: jobController.locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                  bottom: 10,
                ),
                child: Text(
                  'Description',
                  style: TextStyle().copyWith(
                      fontSize: 14, color: Color.fromRGBO(113, 106, 106, 1)),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(
                //     bottom: MediaQuery.of(context).viewInsets.bottom),
                margin: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: TextField(
                  controller: jobController.descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(6),
                      ),
                    ),
                  ),
                  maxLines: 8,
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Center(
                    child: jobController.pickedImage.value.isEmpty
                        ? PickImageBtn()
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(jobController.pickedImage.value),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Center(
                child: Obx(
                  () => SizedBox(
                    child: jobController.pickedImage.value.isEmpty
                        ? null
                        : PickImageBtn(
                            label: 'Change Image',
                          ),
                  ),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                          // bottom: MediaQuery.of(context).viewInsets.bottom
                        ),
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(69, 83, 243, 1)),
                          onPressed: () => jobController.postJob(),
                          child: Text(jobController.isPosting.value
                              ? 'Posting...'
                              : 'Post'),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PickImageBtn extends StatelessWidget {
  final String label;

  PickImageBtn({
    Key? key,
    this.label = 'Pick Image',
  }) : super(key: key);

  final JobAddController jobController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => jobController.pickImage(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 24,
            ),
          ],
        ),
        child: Text(label),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final bool selected;

  CustomButton(
      {required this.icon, required this.label, this.selected = false});

  Color isSelected() {
    return selected
        ? Color.fromRGBO(141, 38, 221, 1)
        : Color.fromRGBO(135, 135, 135, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected(),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon,
          Text(
            '$label',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}

// class ImagePickerHelper extends StatefulWidget {
//   // XFile previousImage;
//   Function setImage;
//   final double imageHeight, imageWidth;

//   ImagePickerHelper(
//     // this.previousImage,
//     this.setImage, {
//     this.imageHeight,
//     this.imageWidth,
//   });

//   @override
//   _ImagePickerState createState() => _ImagePickerState();
// }

// class _ImagePickerState extends State<ImagePickerHelper> {
//   ImagePicker _picker;
//   XFile _pickedImage;

//   @override
//   void initState() {
//     super.initState();
//     _picker = ImagePicker();
//     if (widget.previousImage != null) _pickedImage = widget.previousImage;
//   }

//   // void _pickImage() async {
//   //   XFile selectedImage = await _picker.pickImage(source: ImageSource.gallery);
//   //   var croppedFile = await ImageCropper.cropImage(
//   //       sourcePath: selectedImage.path,
//   //       aspectRatioPresets: [
//   //         CropAspectRatioPreset.square,
//   //         // CropAspectRatioPreset.ratio3x2,
//   //         // CropAspectRatioPreset.original,
//   //         // CropAspectRatioPreset.ratio4x3,
//   //         // CropAspectRatioPreset.ratio16x9
//   //       ],
//   //       androidUiSettings: AndroidUiSettings(
//   //           toolbarTitle: 'Cropper',
//   //           toolbarColor: Theme.of(context).primaryColor,
//   //           toolbarWidgetColor: Colors.white,
//   //           initAspectRatio: CropAspectRatioPreset.original,
//   //           lockAspectRatio: true),
//   //       iosUiSettings: IOSUiSettings(
//   //         minimumAspectRatio: 1.0,
//   //       ));
//   //   File compressedFile = await FlutterImageCompress.compressAndGetFile(
//   //     croppedFile.path,
//   //     '${Directory.systemTemp.path}/${DateTime.now()}.jpg',
//   //     quality: 60,
//   //   );

//   //   // XFile(result.path);

//   //   setState(() {
//   //     if (compressedFile != null) _pickedImage = XFile(compressedFile.path);
//   //     widget.setImage(_pickedImage);
//   //     compressedFile.length().then((value) => print(value));
//   //     print(compressedFile.lengthSync());
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return _pickedImage == null
//         ? Container(
//             height: MediaQuery.of(context).size.height * 0.25,
//             child: Center(
//               child: InkWell(child: PickImageBtn(), onTap: () {}
//                   // _pickImage,
//                   ),
//             ),
//           )
//         : Center(
//             child: Column(
//               // mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   height:
//                       MediaQuery.of(context).size.height * widget.imageHeight,
//                   width: MediaQuery.of(context).size.width * widget.imageWidth,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(
//                       File(_pickedImage.path),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.7,
//                     child: ElevatedButton(
//                       onPressed: _pickImage,
//                       child: Text(
//                         'Select an image',
//                         style: TextStyle(),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
// }

class CustomCommunitySearchDelegate extends SearchDelegate {
  final JobAddController jobController = Get.find();
  late List searchResult;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(
          Icons.clear,
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
    // return FutureBuilder(
    //   future: jobController.getTags(),
    //   builder: (_, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting)
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     else if (!snapshot.hasData)
    //       return Center(child: Text('Choose a community'));
    //     else {
    //       searchResult = snapshot.data ?? [];
    //       return ListView.builder(
    //         itemCount: snapshot.data?.length,
    //         itemBuilder: (_, ind) => ListTile(
    //           title: Text('${snapshot.data?[ind].name}'),
    //           // leading: CircleAvatar(
    //           //   backgroundImage: NetworkImage('${snapshot.data?[ind].name}'),
    //           // ),
    //           onTap: () => close(context, snapshot.data?[ind]),
    //         ),
    //       );
    //     }
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: jobController.tags.length,
        itemBuilder: (_, index) => ListTile(
          title: Text('${jobController.tags[index].name}'),
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage(jobController.tags[index].image ?? NOIMAGE),
          ),
          onTap: () {
            jobController.setSelectedTag(jobController.tags[index]);
            close(context, null);
          },
        ),
      ),
    );
  }
}
