import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/customerPostedJobs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Onboarding/login.dart';
import '../services/authservice.dart';

class PostjobScreen extends StatefulWidget {
  static const routeName = '/postjobscreen';

  @override
  State<PostjobScreen> createState() => _PostjobScreenState();
}

class _PostjobScreenState extends State<PostjobScreen> {
  String title, jobType, desc;
  var valueChooseWorkerType;
  DateTime date;
  List jobTypes = [
    'Mason',
    'Tile Fixer',
    'Carpenter',
    'Painter',
    'Plumber',
    'Electrician',
    'Landscaping',
    'Contractor',
    'Equipment Reparing',
    'Welding',
    'A/C',
    'Cushion Works',
    'Cleaners',
    'Mechanics',
    'CCTV Fixers',
    'Solar Panel Fixers',
    'Curtains',
    'Movers',
    'Pest Control'
  ];
  var pickedImage;
  String jobUrl;
  File _image;
  var email;

  void selectFile() async {
    final picker = ImagePicker();
    try {
      pickedImage = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedImage != null) {
          _image = File(pickedImage.path);
        } else {
          print('No image selected.');
        }
      });
    } on PlatformException catch (e, s) {
    } on Exception catch (e, s) {}
  }

  Future<CloudinaryResponse> prepareUpload() async {
    CloudinaryResponse response;
    if (pickedImage != null) {
      if (pickedImage.path != null) {
        response = await uploadFileOnCloudinary(
          filePath: pickedImage.path,
          resourceType: CloudinaryResourceType.Auto,
        );
        jobUrl = response.url;
        uploadFileDataOnMongo(email, jobUrl);
      }
    }
    return response;
  }

  Future<CloudinaryResponse> uploadFileOnCloudinary(
      {String filePath, CloudinaryResourceType resourceType}) async {
    CloudinaryResponse response;
    try {
      var cloudinary =
          CloudinaryPublic('projecthandyman', 'p5r8psil', cache: false);
      response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath, resourceType: resourceType),
      );
    } on CloudinaryException catch (e, s) {
      print(e.message);
      print(e.request);
    }
    return response;
  }

  void uploadFileDataOnMongo(email, url) {
    AuthService().uploadCustJobImage(email, url).then((val) {
      if (val.data['success']) {
        print('Successfully Uploaded');
      }
    });
  }

  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void httpJob(AnimationController controller) async {
      controller.forward();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      await AuthService().getEmail(token).then((val) {
        if (val.data['success']) {
          email = val.data['email'];
        }
      });

      List data = [email, title, valueChooseWorkerType, desc, date];
      await prepareUpload();
      await AuthService().postJobCustomer(data).then((val) {
        if (val.data['success']) {
          // Navigator.of(context).pushNamed(LoginScreen.routeName);

          Fluttertoast.showToast(
              msg: 'Job Posted',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).buttonColor,
              textColor: Theme.of(context).shadowColor,
              fontSize: 16.0);
        }
      });
      await controller.reset();
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Handyman',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'AlfaSlabOne',
                color: Theme.of(context).buttonColor),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  Navigator.of(context).pushNamed(PostedJobsScreen.routeName);
                }),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 0, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Post a job',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 40),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.0, bottom: 0, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        'Post your requirement',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _form,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Job title',
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).shadowColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: null,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter job title';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          title = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).shadowColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        hint: Text("Worker Type",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        dropdownColor: Theme.of(context).backgroundColor,
                        isExpanded: true,
                        style: TextStyle(color: Colors.white),
                        value: valueChooseWorkerType,
                        onChanged: (newValue) {
                          setState(() {
                            valueChooseWorkerType = newValue;
                          });
                        },
                        items: jobTypes.map((valueItem) {
                          return DropdownMenuItem(
                              value: valueItem, child: Text(valueItem));
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).shadowColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return value;
                        },
                        onChanged: (val) {
                          desc = val;
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //     style: TextStyle(color: Colors.white),
                    //     decoration: InputDecoration(
                    //       labelText: 'Date',
                    //       fillColor: Colors.white,
                    //       labelStyle: TextStyle(color: Colors.white),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //             color: Theme.of(context).shadowColor),
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.white),
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DateTimeFormField(
                        dateTextStyle: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          suffixIcon: Icon(
                            Icons.event_note,
                            color: Colors.white,
                          ),

                          labelText: 'Date',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).shadowColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // enabledBorder: InputBorder(borderSide: )
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) => (e?.day ?? 0) == 1
                            ? 'Please not the first day'
                            : null,
                        onDateSelected: (DateTime value) {
                          date = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => selectFile(),
                        child: Container(
                          height: 100,
                          width: width,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Upload Image',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        height: 46,
                        width: width,
                        decoration: BoxDecoration(
                          // color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ProgressButton(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Text('Post Job',
                                style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            onPressed: (AnimationController controller) async {
                              // print(date.day);

                              await httpJob(controller);
                            }),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
