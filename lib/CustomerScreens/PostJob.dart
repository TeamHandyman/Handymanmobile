import 'dart:ffi';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/customerPostedJobs.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/locationPickerScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../Onboarding/login.dart';
import '../services/authservice.dart';

class PostjobScreen extends StatefulWidget {
  static const routeName = '/postjobscreen';

  @override
  State<PostjobScreen> createState() => _PostjobScreenState();
}

class _PostjobScreenState extends State<PostjobScreen> {
  bool locationSelected = false;
  String title, jobType, desc, latLong;
  double lat, long;
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
  List<String> imageUrls = [];
  String url;
  // File _image;
  List<File> _image = [];
  final picker = ImagePicker();
  File _storedImage;
  var email, fName, lName, proPic, oneSignalID;

  void _takePicture() async {
    final _pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(_pickedImage.path));
    });
    //if (_pickedImage.path == null) retrieveLostData();
  }

  void _remove(int index) {
    setState(() {
      _image.removeAt(index);
    });
  }

  Future<CloudinaryResponse> prepareUpload() async {
    CloudinaryResponse response;
    if (_image.length > 0) {
      for (var i = 0; i < _image.length; i++) {
        response = await uploadFileOnCloudinary(
          image: _image[i],
          filePath: _image[i].path,
          resourceType: CloudinaryResourceType.image,
        );
        url = response.url;
        print(url);
        imageUrls.add(url);
      }
    }
    return response;
  }

  Future<CloudinaryResponse> uploadFileOnCloudinary(
      {File image,
      String filePath,
      CloudinaryResourceType resourceType}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var token = prefs.getString('token');

    CloudinaryResponse response;
    var cloudinary = Cloudinary.signedConfig(
        apiKey: '461133995855746',
        apiSecret: '-QpKX775LFGsnxH4csUfswOTQl4',
        cloudName: 'projecthandyman');

    response = await cloudinary.upload(
      file: filePath,
      fileBytes: image.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: 'cust job images/$email',
      progressCallback: (count, total) {
        print('Uploading image from file with progress: $count/$total');
      },
    );
    return response;
  }

  void moveToMapPage() async {
    latLong = await Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true, builder: (context) => locationPickerScreen()),
    );
    final splitted = latLong.split(" ");
    lat = double.parse(splitted[0]);
    long = double.parse(splitted[1]);
    locationSelected = true;
    setState(() {});
  }

  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void httpJob(AnimationController controller) async {
      controller.forward();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      email = payload['email'];
      fName = payload['fName'];
      lName = payload['lName'];
      oneSignalID = payload['oneSignalID'];
      payload['profilePic'] != null
          ? proPic = payload['profilePic']
          : proPic = "";
      List data = [
        email,
        fName,
        lName,
        proPic,
        title,
        valueChooseWorkerType,
        desc,
        date,
        oneSignalID,
        lat,
        long
      ];

      await prepareUpload();
      if (imageUrls.length < 5) {
        while (imageUrls.length < 5) {
          imageUrls.add("");
        }
      }
      data = data + imageUrls;

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
            // IconButton(
            //     icon: Icon(Icons.list),
            //     onPressed: () {
            //       Navigator.of(context).pushNamed(PostedJobsScreen.routeName);
            //     }),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              moveToMapPage();
                            },
                            child: Container(
                              height: 100,
                              width: width * 0.95,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                  child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      locationSelected
                                          ? latLong
                                          : "Select Location",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: width * 0.95,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListView.builder(
                                    itemCount: _image.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, i) => Dismissible(
                                          key: Key(_image[i].toString()),
                                          direction: DismissDirection.down,
                                          onDismissed:
                                              (DismissDirection direction) {
                                            setState(() {
                                              _image.removeAt(i);
                                            });
                                          },
                                          child: GestureDetector(
                                            // onTap: () {
                                            //   showDialog(
                                            //     context: context,
                                            //     builder: (context) =>
                                            //         imagePop(context, i),
                                            //   );
                                            // },
                                            child: Container(
                                              height: 120,
                                              width: 90,
                                              margin: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: FileImage(_image[i]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )

                                    // MyPhotos(
                                    //   photos[i].id,
                                    //   photos[i].imagestr,
                                    // ),
                                    ),
                              ),
                            ],
                          ),
                          if (_image.length < 5)
                            Positioned(
                              right: 0,
                              top: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: GestureDetector(
                                    onTap: () {
                                      _takePicture();
                                    },
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (_image.length < 1)
                            Positioned(
                              top: 60,
                              left: 10,
                              child: Center(
                                  child: Text(
                                'No photos added',
                                style: TextStyle(color: Colors.white54),
                              )),
                            ),
                        ],
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.view_agenda,
                            color: Theme.of(context).buttonColor,
                            size: 16,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: (() => Navigator.of(context)
                                .pushNamed(PostedJobsScreen.routeName)),
                            child: Text(
                              'View posted jobs',
                              style: TextStyle(
                                  color: Theme.of(context).buttonColor,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
