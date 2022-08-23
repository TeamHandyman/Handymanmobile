import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman/CustomerScreens/navigation.dart';
import 'package:handyman/Onboarding/login.dart';
import 'package:handyman/services/authservice.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, GridFS;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_indicator_button/progress_button.dart';
// import 'package:cloudinary_client/cloudinary_client.dart';
// import 'package:cloudinary_client/models/CloudinaryResponse.dart';

class Goodjobscreen extends StatefulWidget {
  static const routeName = '/goodjob';
  @override
  State<Goodjobscreen> createState() => _GoodjobscreenState();
}

class _GoodjobscreenState extends State<Goodjobscreen> {
  File _image;
  var fName, lName;
  String propicUrl;
  var pickedImage;
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
        propicUrl = response.url;
        uploadFileDataOnMongo(data[1], propicUrl);
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
    AuthService().uploadPropic(email, url).then((val) {
      if (val.data['success']) {
        print('Successfully Uploaded');
      }
    });
  }

  // bool isloaded = false;
  // var result;

  // fetch() async {
  //   var response =
  //       await http.get('https://projecthandyman.herokuapp.com/image');
  //   result = jsonDecode(response.body);
  //   print(result[0]['image']);
  //   setState(() {
  //     isloaded = true;
  //   });
  // }

  String valueChooseGen, valueChooseDis;
  List genders = ['Male', 'Female'];
  List districts = [
    'Colombo',
    'Gampaha',
    'Kalutara',
    'Kandy',
    'Matale',
    'Nuwara Eliya',
    'Galle',
    'Matara',
    'Hambantota',
    'Jaffna',
    'Kilinochchi',
    'Mannar',
    'Vavuniya',
    'Mullativu',
    'Batticaloa',
    'Ampara',
    'Trincomalee',
    'Kurunegala',
    'Puttalam',
    'Anuradhapura',
    'Polonnaruwa',
    'Badulla',
    'Moneragala',
    'Ratnapura',
    'Kegalle'
  ];
  List data;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void httpJob(AnimationController controller) async {
      controller.forward();
      await prepareUpload();

      await AuthService().addUserCustomer(data).then((val) {
        if (val.data['success']) {
          Navigator.of(context).pushNamed(LoginScreen.routeName);

          Fluttertoast.showToast(
              msg: 'Successfully Registered',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).buttonColor,
              textColor: Theme.of(context).shadowColor,
              fontSize: 16.0);
        }
      });
      controller.reset();
    }

    data = ModalRoute.of(context).settings.arguments as List;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 15, bottom: 30),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 0, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Good job',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).buttonColor,
                        fontSize: 40),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
              child: Text(
                'Thank you for signing up for Handyman. To give you a personalised experience we would like to know more about you',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              _image == null ? null : FileImage(_image),
                          radius: 50,
                          child: _image == null
                              ? Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 110,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).buttonColor,
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.camera_alt_rounded),
                              color: Theme.of(context).backgroundColor,
                              onPressed: () {
                                selectFile();
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 5, bottom: 5),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'First Name',
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
                            keyboardType: TextInputType.name,
                            onChanged: (val) {
                              fName = val;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 5, bottom: 5),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'Last Name',
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
                            keyboardType: TextInputType.name,
                            onChanged: (val) {
                              lName = val;
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 5, bottom: 5),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                  Icons.male,
                                  color: Theme.of(context).buttonColor,
                                )),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).buttonColor,
                                ),
                                hint: Text("Gender",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                dropdownColor:
                                    Theme.of(context).backgroundColor,
                                isExpanded: true,
                                style: TextStyle(color: Colors.white),
                                value: valueChooseGen,
                                onChanged: (newValue) {
                                  setState(() {
                                    valueChooseGen = newValue;
                                  });
                                },
                                items: genders.map((valueItem) {
                                  return DropdownMenuItem(
                                      value: valueItem, child: Text(valueItem));
                                }).toList(),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 5, bottom: 5),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).buttonColor,
                                )),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).buttonColor,
                                ),
                                hint: Text("District",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                dropdownColor:
                                    Theme.of(context).backgroundColor,
                                isExpanded: true,
                                style: TextStyle(color: Colors.white),
                                value: valueChooseDis,
                                onChanged: (newValue) {
                                  setState(() {
                                    valueChooseDis = newValue;
                                  });
                                },
                                items: districts.map((valueItem) {
                                  return DropdownMenuItem(
                                      value: valueItem, child: Text(valueItem));
                                }).toList(),
                              ),
                            )),
                      ],
                    ))),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: GestureDetector(
                    child: Container(
                      height: 46,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ProgressButton(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Text('Let\'s Go',
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          onPressed: (AnimationController controller) async {
                            data.addAll(
                                [fName, lName, valueChooseGen, valueChooseDis]);
                            await httpJob(controller);
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
